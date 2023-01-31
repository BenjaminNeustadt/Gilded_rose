class GildedRose

  PRODUCT = {
    cheese: "Aged Brie" ,
    ticket: "Backstage passes to a TAFKAL80ETC concert",
    product_3: "Sulfuras, Hand of Ragnaros"
  }
  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.sell_in > 0
        unless item.quality == 0
          item.quality = item.quality - 1
          item.sell_in = item.sell_in - 1
        end
      else
          item.quality = item.quality - 2
          item.sell_in = item.sell_in - 1
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

class Brie

  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = "Aged Brie"
    @sell_in = sell_in
    @quality = quality
    @quality_toll = 1
  end

end