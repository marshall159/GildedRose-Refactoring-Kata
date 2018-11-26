require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]

      GildedRose.new(items).update_quality()

      expect(items[0].name).to eq "foo"
    end

    it "decreases the #sell_in value" do
      items = [Item.new("foo", 20, 20)]

      gr = GildedRose.new(items)

      expect { gr.update_quality() }.to change { items[0].sell_in }.by(-1)
    end

    it "decreases the #quality value" do
      items = [Item.new("foo", 20, 20)]

      gr = GildedRose.new(items)

      expect { gr.update_quality() }.to change { items[0].quality }.by(-1)
    end

    it "#quality is never negative" do 
      items = [Item.new("foo", 0, 0)]

      GildedRose.new(items).update_quality()

      expect(items[0].quality).to be >= 0
    end

    it "“Aged Brie” increases in #quality the older it gets" do 
      items = [Item.new("Aged Brie", 10, 48)]

      gr = GildedRose.new(items)

      expect { gr.update_quality() }.to change { items[0].quality }.by(1)
    end

    it "#quality is never more than 50" do 
      items = [Item.new("Aged Brie", 10, 49)]

      gr = GildedRose.new(items)

      expect { gr.update_quality() }.to change { items[0].quality }.by(1)

      gr.update_quality()

      expect(items[0].quality).to eq(50)
    end

    it "#quality degrades twice as fast after sell by date has passed" do 
      items = [Item.new("foo", 0, 20)]

      gr = GildedRose.new(items)

      expect { gr.update_quality() }.to change { items[0].quality }.by(-2)
    end
  end

end
