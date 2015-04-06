module Updater
  class BaseItem
    def initialize(item)
      @item = item
    end

    def update
    end

    private

    def self.minimum_quality(value)
      @@minimum_quality = value
    end

    def self.maximum_quality(value)
      @@maximum_quality = value
    end

    def increase_quality
      @item.quality += 1
      if @@maximum_quality
        @item.quality = [@@maximum_quality, @item.quality].min
      end
    end

    def decrease_quality
      @item.quality -=1
      if @@minimum_quality
        @item.quality = [@@maximum_quality, @item.quality].max
      end
    end
  end

  class AgedBrie < BaseItem
    maximum_quality 50

    def update
      @item.sell_in -=1
      increase_quality
      increase_quality if @item.sell_in < 0
    end
  end

  class Sulfuras < BaseItem
    maximum_quality 80
  end

  class BackstagePass < BaseItem
    maximum_quality 50

    def update
      @item.sell_in -=1
      increase_quality
      increase_quality if @item.sell_in < 5
      increase_quality if @item.sell_in < 10
      @item.quality = 0 if @item.sell_in < 0
    end
  end

  class Conjured < BaseItem
    maximum_quality 50

    def update
      @item.sell_in -=1
      increase_quality
      increase_quality
    end
  end
end

def update_quality(items)
  items.each do |item|
    ItemUpdater.for(item).update
  end
end

class ItemUpdater
  ITEM_MAPPER = {
    "Aged Brie" => Updater::AgedBrie,
    "Sulfuras, Hand of Ragnaros" => Updater::Sulfuras,
    "Backstage passes to a TAFKAL80ETC concert" => Updater::BackstagePass,
    "Conjured" => Updater::Conjured
  }

  def self.for(item)
    ITEM_MAPPER[item.name].new(item)
  end
end
######### DO NOT CHANGE BELOW #########

Item = Struct.new(:name, :sell_in, :quality)
