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

end

class GildedRose

include UpdateOperators

  def initialize(items)
    @items = items
  end

  attr_accessor :items

  def standard_update(item, value = 1)

    if item.sell_in > 0

      unless item.quality == 0
        decrease_quality(item, value)
        decrease_sell_in(item)
      end

    else

      unless item.quality == 0
        decrease_quality(item, 2)
      end

    end

  end

  def update_quality()

    items.each do |item|

      if item.respond_to? :decrease_speed
        standard_update(item, 2)

      elsif item.respond_to? :update_self
        item.update_self
      else
        standard_update(item)
      end

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
  attr_reader :decrease_speed
  
  def initialize(name, sell_in, quality) 
    @name = name
    @sell_in = sell_in
    @quality = quality
    @decrease_speed = 2
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

    if self.sell_in > 0
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
