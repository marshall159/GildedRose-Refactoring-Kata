class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      next if sulfuras?(item)

      decrease_sell_in(item)

      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        decrease_quality(item)
      else
        increase_quality(item)
        backstage_passes(item) if backstage_passes?(item)
      end

      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            decrease_quality(item)
          else
            item.quality = item.quality - item.quality # Backstage passes after concert drops to zero
          end
        else
          increase_quality(item)
        end
      end

    end
  end

  private

  def increase_quality(item)
    if item.quality < 50
      item.quality += 1
    end
  end

  def decrease_quality(item)
    if item.quality > 0
      item.quality -= 1
    end
  end

  def decrease_sell_in(item)
    item.sell_in -= 1
  end

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def backstage_passes?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def backstage_passes(item)
      if item.sell_in < 11
        increase_quality(item)
      end
      if item.sell_in < 6
        increase_quality(item)
      end
  end

end