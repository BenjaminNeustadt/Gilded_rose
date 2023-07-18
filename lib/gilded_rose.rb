require_relative("update_operators_helper")
require_relative("item")
require_relative("special_items/conjured_item")
require_relative("special_items/sulfuras")
require_relative("special_items/backstage")
require_relative("special_items/brie")

class GildedRose

include UpdateOperators

  def initialize(items)
    @items = items
  end

  attr_accessor :items

  def update_quality
    items.each do |item|
      item.respond_to?(:update_self) ? item.update_self : default_update(item)
    end
  end

end
