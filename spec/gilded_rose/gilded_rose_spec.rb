# require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'gilded_rose'

describe GildedRose do
  describe '#update_quality' do
    it 'decreases sell-in and quality by 1' do
      test_update_quality_for 'foo', 1, 1 do
        {
          sell_in: 0,
          quality: 0
        }
      end
    end

    it 'decreases quality and sell-in by as many times as is called' do
      test_update_quality_for 'foo', 20, 30, days: 10 do
        {
          sell_in: 10,
          quality: 20
        }
      end
    end

    context 'when the values are at 0' do
      it 'update_quality does not decrease it' do
        test_update_quality_for 'foo', 0, 0 do
          {
            quality: 0
          }
        end
      end

      it 'decreases sell-in' do
        test_update_quality_for 'foo', 0, 0 do
          {
            sell_in: -1
          }
        end
      end
    end

    context 'once the sell date has passed' do
      it 'quality decreases twice as fast' do
        test_update_quality_for 'foo', 0, 4 do
          {
            quality: 2
          }
        end
      end
    end

    context '-- SPECIAL ITEMS --' do
      context 'Aged Brie' do
        it 'quality increases as days pass' do
          test_update_quality_for 'Aged Brie', 3, 4 do
            {
              quality: 5
            }
          end
        end

        it 'quality does not increase above 50' do
          test_update_quality_for 'Aged Brie', 3, 50 do
            {
              quality: 50
            }
          end
        end
      end

      context 'Sulfuras, Hand of Ragnaros' do
        it 'decreases in neither sell_in nor quality' do
          test_update_quality_for 'Sulfuras, Hand of Ragnaros', 23, 35 do
            {
              sell_in: 23,
              quality: 35
            }
          end
        end
      end

      context 'Backstage passes' do
        context 'when there are more than 10 days left' do
          it 'inceases quality by 1' do
            test_update_quality_for 'Backstage passes to a TAFKAL80ETC concert', 11, 20 do
              {
                quality: 21
              }
            end
          end
        end

        context 'when there are 10 days or less left' do
          it 'inceases quality by 2' do
            test_update_quality_for 'Backstage passes to a TAFKAL80ETC concert', 10, 20 do
              {
                quality: 22
              }
            end
          end
        end

        context 'when there are 5 days or less left' do
          it 'inceases quality by 3' do
            test_update_quality_for 'Backstage passes to a TAFKAL80ETC concert', 5, 20 do
              {
                quality: 23
              }
            end
          end
        end

        context 'when there 0 days or less left' do
          it 'drops the quality to 0' do
            test_update_quality_for 'Backstage passes to a TAFKAL80ETC concert', 0, 20 do
              {
                quality: 0
              }
            end
          end
        end
      end
    end
  end

  def test_update_quality_for(name, value, quality, days: 1, &blk)
    item = GildedRose::Item.new(name, value, quality)
    gilded_rose = GildedRose::GildedRose.new([item])

    days.times { gilded_rose.update_quality }

    expected_attributes = blk.call
    expected_attributes.each do |attr, value|
      expect(item.send(attr)).to eq value
    end
  end
end
