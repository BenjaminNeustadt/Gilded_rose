module UpdateOperator

  QUALITY_INCREMENT = 1

  def standard_decrease(item)
    item.quality = item.quality - QUALITY_INCREMENT
    item.sell_in = item.sell_in - 1
  end

  def perished_decrease(item)
    item.quality = item.quality - (QUALITY_INCREMENT * 2)
    item.sell_in = item.sell_in - 1
  end

end

class GildedRose

include UpdateOperator

  def initialize(items)
    @items = items
  end

  attr_accessor :items

  def standard_update(item)

    if item.sell_in > 0
      unless item.quality == 0
        standard_decrease(item)
      end
    else
        perished_decrease(item)
    end

  end

  def update_quality()

    items.each do |item|

      if item.respond_to? :update_self
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

  QUALITY_INCREMENT = 1

  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def decrease_sell_in
    self.sell_in -= 1
  end

  def update_self

    if self.sell_in <= 0

      self.quality = 0

    elsif self.sell_in > 10

      self.quality += QUALITY_INCREMENT
      decrease_sell_in

    elsif self.sell_in <= 5 

      self.quality += (QUALITY_INCREMENT * 3)
      decrease_sell_in

    elsif (self.sell_in <= 10)

      self.quality += (QUALITY_INCREMENT * 2)
      decrease_sell_in

    end

  end

end

class Brie

  QUALITY_INCREMENT = 1

  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def update_self

    if self.sell_in > 0
      self.quality += QUALITY_INCREMENT
      self.sell_in -= 1
    else
      unless self.quality == 50
        self.quality += (QUALITY_INCREMENT * 2)
        self.sell_in -= 1
      end
    end

  end

end
