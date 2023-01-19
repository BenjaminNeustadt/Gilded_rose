class GildedRose

 PRODUCT = {
   cheese: "Aged Brie" ,
   ticket: "Backstage passes to a TAFKAL80ETC concert",
   product_3: "Sulfuras, Hand of Ragnaros"
 }

  MAX_QUALITY = 50

  def initialize(items)
    @items = items
  end

  attr_accessor :items

  def increase_quality(item)
    item.quality += 1
  end

   def decrease_quality(item)
     item.quality -=  1
   end

  def less_than_limit(item)
    item < MAX_QUALITY
  end

  def usable?(item)
    item.quality > 0
  end

  def update_quality()

    @items.each do |item|
                                              #:NOTE: method check here is not necessary
      if !PRODUCT.values.include?(item.name) && usable?(item)
        decrease_quality(item)
      else

        if less_than_limit(item.quality)
          increase_quality(item)

          if item.name == PRODUCT[:ticket]

            if item.sell_in < 6
              item.quality = item.quality + 1
            end

          end
        end

      end

      if item.name != PRODUCT[:product_3]
        item.sell_in = item.sell_in - 1
      end

      if item.sell_in < 0

        if item.name != PRODUCT[:cheese]

          if item.name != PRODUCT[:ticket]

            if item.quality > 0
              if item.name != PRODUCT[:product_3]
                item.quality = item.quality - 1
              end
            end

          end

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

