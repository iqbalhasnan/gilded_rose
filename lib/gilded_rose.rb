module Updater
  class BaseItem
    def initialize(item)
      @item = item
    end

    def update
    end

    def minimum_quality(value)
      @@minimum_quality = value
    end

    def maximum_quality(value)
      @@maximum_quality = value
    end

    def add_quality
      @item.quality += 1
    end

    def remove_quality
      @item.quality -=1
    end
  end

  class AgedBrie < BaseItem
  end

  class Sulfuras < BaseItem
  end

  class BackstagePass < BaseItem
  end

  class Conjured < BaseItem
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
