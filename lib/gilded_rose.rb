module UpdateOperators

  QUALITY_INCREMENT = 1

  def decrease_quality(item, value = QUALITY_INCREMENT)
    item.quality -= (QUALITY_INCREMENT * value) 
    item.quality = [item.quality, 0].max
  end

  def decrease_sell_in(item = self)
    item.sell_in -= 1
  end

  def increment_quality(value = QUALITY_INCREMENT)
    self.quality += (QUALITY_INCREMENT * value)
  end

  def expired?(item)
    item.quality == 0
  end

  def still_sellable(item)
    item.sell_in > 0
  end

  def default_update(item, value = 1)
    if still_sellable(item)
      value = item.decrement_pace if item.respond_to? :decrement_pace
      decrease_quality(item, value);
      decrease_sell_in(item) unless expired?(item)
    else
      decrease_quality(item, 2) unless expired?(item)
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

class ConjuredItem < Item
  attr_accessor :name, :sell_in, :quality
  attr_reader :decrement_pace
  
  def initialize(name, sell_in, quality) 
    @name = name
    @sell_in = sell_in
    @quality = quality
    @decrement_pace = 2
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

  QUALITY_INCREMENT = 1

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
      unless self.quality == 50
        increment_quality(2)
        decrease_sell_in
      end
    end

  end

end
