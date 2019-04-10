require_relative 'quality_control'

module GildedRose
  class ConjuredQualityControl < QualityControl
    QUALITY_CHANGE = -2

    def quality_change_value(_item)
      QUALITY_CHANGE
    end
  end
end
