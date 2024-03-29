require_relative '../lib/gilded_rose'

describe GildedRose do

  describe "#update_quality" do

    # ----------------- 
    # Standard products 
    # ----------------- 

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "does not change the name for multiple items" do
      items = [Item.new("foo", 0, 0), Item.new("baz", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[1].name).to eq "baz"
    end

    it "decreases the quality of product" do
      items = [Item.new("milk", 1, 4)]
      expect(items[0].quality).to eq 4
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 3
    end

    it "the sell in date in decreased at the end of the day" do
      items = [Item.new("chocolate", 3, 3)]
      expect(items[0].sell_in).to eq 3
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 2
    end

    it "the quality of an item is never negative" do
      items = [Item.new("chocolate", 3, 0)]
      expect(items[0].sell_in).to eq 3
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "decreases the quality twice as fast once sell by date has passed" do
      items = [Item.new("chocolate", 1, 5)]
      expect(items[0].sell_in).to eq 1
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 0
      expect(items[0].quality).to eq 4
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 2
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    # ----------------- 
    # Special items
    # ----------------- 

    # /*/ BRIE
    # ----------------- 

    it "Brie increases in quality as sell-by-date approaches" do

      items = [Item.new("Aged Brie", 8, 1)]

      expect(items[0].quality).to eq 1
      expect(items[0].sell_in).to eq 8
      
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 2
      expect(items[0].sell_in).to eq 7

      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 6
      expect(items[0].quality).to eq 3

    end

    it "Brie increases twice as fast(2) once sell by-date has passed" do

      items = [Item.new("Aged Brie", 1, 2)]

      expect(items[0].quality).to eq 2
      expect(items[0].sell_in).to eq 1
      
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 3
      expect(items[0].sell_in).to eq 0

      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq -1
      expect(items[0].quality).to eq 5

    end

    it "The quality of an item is never more than 50" do
      items = [Item.new("Aged Brie", 1, 49)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    # /*/ SULFURAS : quality always 80
    # ----------------- 

    it "Sulfuras never decreases in quality, or sell-in" do

      items = [Item.new("Sulfuras, Hand of Ragnaros", 1, 80)]
      expect(items[0].quality).to eq 80
      expect(items[0].sell_in).to eq 1
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 1
      expect(items[0].quality).to eq 80
    end


    it "Sulfuras always has a quality of 80" do

      items = [Item.new("Sulfuras, Hand of Ragnaros", 1, 50)]
      expect(items[0].quality).to eq 50
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 80
    end

    # /*/ BACKSTAGE PASSES:
    # ----------------- 


    it "Backstage passes increases in quality as SellIn value approaches; above 10" do

      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 8)]
      expect(items[0].quality).to eq 8
      expect(items[0].sell_in).to eq 11
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 10
      expect(items[0].quality).to eq 9
    end

    it "Backstage passes increases in quality(by 2) as SellIn value approaches; less than or equal to 10" do

      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 8)]
      expect(items[0].quality).to eq 8
      expect(items[0].sell_in).to eq 10
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 9
      expect(items[0].quality).to eq 10
    end

    it "Backstage passes increases in quality(by 3) as SellIn value approaches; less than or equal to 5" do

      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 8)]
      expect(items[0].quality).to eq 8
      expect(items[0].sell_in).to eq 5
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 4
      expect(items[0].quality).to eq 11

    end

    it "Backstage passes drops to 0 quality after the concert" do

      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 7)]
      expect(items[0].quality).to eq 7
      expect(items[0].sell_in).to eq 1
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 0
      expect(items[0].quality).to eq 10
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    # /*/ CONJURED ITEMS:
    # ----------------- 

    it "Conjured item degrades in quality twice as fast, therefoe at a pace of 2" do

      items = [Item.new("Conjured Item", 10, 20)]
      expect(items[0].quality).to eq 20
      expect(items[0].sell_in).to eq 10
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 18

    end

    it "does not change the name" do
      items = [Item.new("Conjured Item", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "Conjured Item"
    end

    it "does not change the name for multiple items" do
      items = [Item.new("foo", 0, 0), Item.new("baz", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[1].name).to eq "baz"
    end

    it "decreases the quality of product" do
      items = [Item.new("Conjured Item", 1, 4)]
      expect(items[0].quality).to eq 4
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 2
    end

    it "the sell in date in decreased at the end of the day" do
      items = [Item.new("Conjured Item", 3, 3)]
      expect(items[0].sell_in).to eq 3
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 2
    end

    it "the quality of an item is never negative" do
      items = [Item.new("Conjured Item", 3, 0)]
      expect(items[0].sell_in).to eq 3
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "decreases the quality twice as fast once sell by date has passed" do
      items = [Item.new("Conjured Item", 1, 5)]
      expect(items[0].sell_in).to eq 1
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 0
      expect(items[0].quality).to eq 3
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 1
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

  end
end