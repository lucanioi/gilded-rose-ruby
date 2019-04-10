require_relative 'gilded_rose/item'
require_relative 'gilded_rose/quality_control_factory'

module GildedRose
  class GildedRose
    def initialize(items)
      @items = items
    end

    def update_quality
      @items.map &method(:update_quality_for_item)
    end

    def update_quality_for_item(item)
      quality_control = QualityControlFactory.for_item(item)
      quality_control.update(item)
    end
  end
end
