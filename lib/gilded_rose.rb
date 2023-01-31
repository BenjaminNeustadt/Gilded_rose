class GildedRose

  def initialize(items)
    @items = items
  end

  def standard_decrease(item)
    item.quality = item.quality - 1
    item.sell_in = item.sell_in - 1
  end

  def perished_decrease(item)
    item.quality = item.quality - 2
    item.sell_in = item.sell_in - 1
  end

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

    @items.each do |item|

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

  def update_self

    if self.sell_in <= 0

      self.quality = 0

    elsif self.sell_in > 10

      self.quality += QUALITY_INCREMENT
      self.sell_in -= 1

    elsif self.sell_in <= 5 

      self.quality += (QUALITY_INCREMENT * 3)
      self.sell_in -= 1

    elsif (self.sell_in <= 10)

      self.quality += (QUALITY_INCREMENT * 2)
      self.sell_in -= 1

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
