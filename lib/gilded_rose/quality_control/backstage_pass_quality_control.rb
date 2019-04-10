require_relative 'quality_control'

module GildedRose
  class BackstagePassQualityControl < QualityControl
    def update_quality(item)
      item.sell_in <= 0 ? item.quality = 0 : super
    end

    def quality_change_value(item)
      case item.sell_in
      when 11..Float::INFINITY
        1
      when 6..10
        2
      when 0..5
        3
      end
    end
  end
end
