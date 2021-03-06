class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      next if sulfuras?(item)

      item.decrease_sell_in

      change_quality(item)

      backstage_passes_increase_quality_near_sellin(item) if backstage_passes?(item)

      past_sellin(item) if past_sellin?(item)

    end
  end

  private

  def change_quality(item)
    if aged_brie?(item) or backstage_passes?(item)
      increase_quality(item)
    else
      decrease_quality(item)
    end
  end

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

  def past_sellin?(item)
    item.sell_in < 0
  end

  def past_sellin(item)
      backstage_after_concert(item) if backstage_passes?(item)

      if aged_brie?(item)
        increase_quality(item)
      else
        decrease_quality(item)
      end
  end

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def backstage_passes?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def aged_brie?(item)
    item.name == "Aged Brie"
  end

  def backstage_passes_increase_quality_near_sellin(item)
      if item.sell_in < 11
        increase_quality(item)
      end
      if item.sell_in < 6
        increase_quality(item)
      end
  end

  def backstage_after_concert(item) 
    item.quality = item.quality - item.quality
  end

end