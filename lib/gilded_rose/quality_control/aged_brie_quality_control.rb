require_relative 'quality_control'

module GildedRose
  class AgedBrieQualityControl < QualityControl
    private

    def update_quality(item)
      unless item.quality >= MAXIMUM_QUALITY
        item.quality += 1
      end
    end
  end
end
