require_relative '../lib/gilded_rose'

describe GildedRose do

  describe "#update_quality" do

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

    it "updates the quality of Brie" do
      items = [Item.new("Aged Brie", 1, 0)]
      expect(items[0].quality).to eq 0
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 1
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
  end

end

=begin
NOTES
it decreases twice as fast once the sell by date has passed: sell_in = 0, quality = 8, => 4
it never decreases bellow 0
the quality is never more than 50
ticket,10, 8, 5, 3, 0
=end