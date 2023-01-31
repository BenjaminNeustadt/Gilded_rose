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

  def update_quality()
    @items.each do |item|

      if item.respond_to? :update_self

        item.update_self

      else

        if item.sell_in > 0
          unless item.quality == 0
            standard_decrease(item)
          end
        else
            perished_decrease(item)
        end
      end

    end

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

  QUALITY_INCREMENT = 1

  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def update_self

    # if self.quality >= 11

      self.quality += QUALITY_INCREMENT
      self.sell_in -= 1

    # elsif (self.quality < 10 && self.quality > 5)

      # self.quality += (QUALITY_INCREMENT * 2)
      # self.sell_in -= 1

    # elsif self.quality < 5 && self.quality > 0

    # else

    # end

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

  #     if item.name != PRODUCT[:cheese] and item.name != PRODUCT[:ticket]

  #       if item.quality > 0
  #         if item.name != "Sulfuras, Hand of Ragnaros"
  #           item.quality = item.quality - 1
  #         end
  #       end
  #     else
  #       if item.quality < 50
  #         item.quality = item.quality + 1
  #         if item.name == "Backstage passes to a TAFKAL80ETC concert"
  #           if item.sell_in < 11
  #             if item.quality < 50
  #               item.quality = item.quality + 1
  #             end
  #           end
  #           if item.sell_in < 6
  #             if item.quality < 50
  #               item.quality = item.quality + 1
  #             end
  #           end
  #         end
  #       end
  #     end
  #     if item.name != "Sulfuras, Hand of Ragnaros"
  #       item.sell_in = item.sell_in - 1
  #     end
  #     if item.sell_in < 0
  #       if item.name != "Aged Brie"
  #         if item.name != "Backstage passes to a TAFKAL80ETC concert"
  #           if item.quality > 0
  #             if item.name != "Sulfuras, Hand of Ragnaros"
  #               item.quality = item.quality - 1
  #             end
  #           end
  #         else
  #           item.quality = item.quality - item.quality
  #         end
  #       else
  #         if item.quality < 50
  #           item.quality = item.quality + 1
  #         end
  #       end
  #     end
  #   end
  # end
