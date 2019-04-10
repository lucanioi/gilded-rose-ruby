module GildedRose
  class QualityControl
    MINIMUM_QUALITY = 0
    MAXIMUM_QUALITY = 50

    def update(item)
      update_quality(item)
      update_sell_in(item)
    end

    def update_quality(item)
      unless item.quality <= MINIMUM_QUALITY
        item.quality += quality_change_value(item)
      end
    end

    def update_sell_in(item)
      item.sell_in -= 1
    end

    def quality_change_value(item)
      item.sell_in <= 0 ? -2 : -1
    end
  end
end
