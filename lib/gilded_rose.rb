module UpdateOperators

  DEFAULT_INCREMENT = 1

  def decrease_quality(item, quality_increase = DEFAULT_INCREMENT)
    item.quality -= (DEFAULT_INCREMENT * quality_increase) 
    item.quality = [item.quality, 0].max
  end

  def decrease_sell_in(item = self)
    item.sell_in -= 1
  end

  def increment_quality(quality_increase = DEFAULT_INCREMENT)
    self.quality += (DEFAULT_INCREMENT * quality_increase)
  end

  def expired?(item)
    item.quality == 0
  end

  def still_sellable(item)
    item.sell_in > 0
  end

  def max_quality
    self.quality == 50
  end

  def default_update(item, quality_increase = 1)
    return if expired?(item)
    if still_sellable(item)
      decrease_quality(item, quality_increase);
      decrease_sell_in(item)
    else
      decrease_quality(item, 2)
    end
  end

end

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

# /*/ SPECIAL CLASSES FOR SPECIAL ITEMS
class ConjuredItem
  include UpdateOperators

  attr_accessor :name, :sell_in, :quality
  attr_reader :decrement_pace
  
  def initialize(name, sell_in, quality) 
    @name = name
    @sell_in = sell_in
    @quality = quality
    @decrement_pace = 2
  end

  def update_self
    decrease_quality(self, decrement_pace)
    decrease_sell_in(self)
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end


class Sulfuras

  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = 80
  end

  def update_self
    self.quality
    self.sell_in
  end

end

class BackstagePass

  include UpdateOperators


  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def update_self

    if self.sell_in <= 0
      self.quality = 0
    elsif self.sell_in > 10
      increment_quality
      decrease_sell_in
    elsif self.sell_in <= 5 
      increment_quality(3)
      decrease_sell_in
    elsif (self.sell_in <= 10)
      increment_quality(2)
      decrease_sell_in
    end

  end

end

class Brie

  include UpdateOperators

  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def update_self

    if still_sellable(self)
      increment_quality
      decrease_sell_in
    else
      increment_quality(2) and decrease_sell_in unless max_quality
    end

  end

end
