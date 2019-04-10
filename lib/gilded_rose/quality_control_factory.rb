require_relative 'quality_control/quality_control'
require_relative 'quality_control/aged_brie_quality_control'
require_relative 'quality_control/sulfura_quality_control'
require_relative 'quality_control/backstage_pass_quality_control'

module GildedRose
  module QualityControlFactory
    module_function

    def for_item(item)
      case item.name
      when /aged brie/i
        AgedBrieQualityControl.new
      when /sulfura/i
        SulfuraQualityControl.new
      when /backstage pass/i
        BackstagePassQualityControl.new
      else
        QualityControl.new
      end
    end
  end
end
