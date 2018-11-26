class GildedRose

  def initialize(items)
    # Do not alter items property
    @items = items
  end

  def update_quality()
    @items.each do |item|
      next if sulfuras?(item)

      decrease_sell_in(item)

      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        decrease_quality(item)
      else
        if quality_below_max?(item)
          increase_quality(item)
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                increase_quality(item)
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                increase_quality(item)
              end
            end
          end
        end
      end

      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            decrease_quality(item)
          else
            item.quality = item.quality - item.quality # Backstage passes after concert drops to zero
          end
        else
          if item.quality < 50
            increase_quality(item)
          end
        end
      end

    end
  end

  private

  def increase_quality(item)
    item.quality += 1
  end

  def decrease_quality(item)
    if item.quality > 0
      item.quality -= 1
    end
  end

  def decrease_sell_in(item)
    item.sell_in -= 1
  end

  def quality_below_max?(item)
    item.quality < 50
  end

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

end

# Do not alter Item class
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end