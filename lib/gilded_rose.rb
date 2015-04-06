module Updater
  class BaseItem
    def initialize(item)
      @item = item
    end

    def update
    end

    def self.minimum_quality(value)
      @@minimum_quality = value
    end

    def self.maximum_quality(value)
      @@maximum_quality = value
    end

    def increase_quality
      @item.quality += 1
    end

    def decrease_quality
      @item.quality -=1
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
      decrease_quality
      decrease_quality if @item.sell_in < 0
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
    if item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert'
      if item.quality > 0
        if item.name != 'Sulfuras, Hand of Ragnaros'
          item.quality -= 1
        end
      end
    else
      if item.quality < 50
        item.quality += 1
        if item.name == 'Backstage passes to a TAFKAL80ETC concert'
          if item.sell_in < 11
            if item.quality < 50
              item.quality += 1
            end
          end
          if item.sell_in < 6
            if item.quality < 50
              item.quality += 1
            end
          end
        end
      end
    end
    if item.name != 'Sulfuras, Hand of Ragnaros'
      item.sell_in -= 1
    end
    if item.sell_in < 0
      if item.name != "Aged Brie"
        if item.name != 'Backstage passes to a TAFKAL80ETC concert'
          if item.quality > 0
            if item.name != 'Sulfuras, Hand of Ragnaros'
              item.quality -= 1
            end
          end
        else
          item.quality = item.quality - item.quality
        end
      else
        if item.quality < 50
          item.quality += 1
        end
      end
    end
  end
end

######### DO NOT CHANGE BELOW #########

Item = Struct.new(:name, :sell_in, :quality)
