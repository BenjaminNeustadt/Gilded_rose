require_relative("update_operators_helper")
require_relative("item")
require_relative("special_items/conjured_item")
require_relative("special_items/sulfuras")
require_relative("special_items/backstage")
require_relative("special_items/brie")



class GildedRose
include UpdateOperators

  ITEM_CLASSES = {
    "Aged Brie" => Brie,
    "Sulfuras, Hand of Ragnaros" => Sulfuras,
    "Backstage passes to a TAFKAL80ETC concert" => BackstagePass,
    "Conjured Item" => ConjuredItem,
  }

  def initialize(items)
    @items = items
  end


  attr_accessor :items

  def synthesize_values_of(item, special_item) 
    item.quality = special_item.quality
    item.sell_in = special_item.sell_in
  end

  def update_quality
    @items.each do |item|
      special_item = ITEM_CLASSES[item.name]&.new(item.name, item.sell_in, item.quality)
      if special_item
        special_item.update_self
        synthesize_values_of(item, special_item)
      else
        default_update(item)
      end
    end
  end

end