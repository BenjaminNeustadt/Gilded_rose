require_relative("update_operators_helper")
require_relative("item")
require_relative("special_items/conjured_item")
require_relative("special_items/sulfuras")
require_relative("special_items/backstage")
require_relative("special_items/brie")

# class GildedRose

# include UpdateOperators

#   def initialize(items)
#     @items = items
#   end

#   attr_accessor :items

#   def update_quality
#     items.each do |item|
#       item.respond_to?(:update_self) ? item.update_self : default_update(item)
#     end
#   end

# end

class GildedRose
include UpdateOperators

  ITEM_CLASSES = {
    "Aged Brie" => Brie,
    "Sulfuras, Hand of Ragnaros" => Sulfuras,
    "Backstage passes to a TAFKAL80ETC concert" => BackstagePass
  }

  def initialize(items)
    @items = items
  end


  attr_accessor :items

  def update_quality
    @items.each do |item|
      special_item = ITEM_CLASSES[item.name]&.new(item.name, item.sell_in, item.quality)
      # p item.to_s
      if special_item
        # p special_item
        # p special_item.class
        p special_item.quality
        special_item.update_self
        p special_item.quality
      else
        # p "the item is this: #{item.class}"

        default_update(item)
      end
    end
  end

end