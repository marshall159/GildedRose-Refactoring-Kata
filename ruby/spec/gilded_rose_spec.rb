require 'gilded_rose'
require 'item'
require 'inventory_item'

describe GildedRose do
  let(:items) { [InventoryItem.new("foo", 20, 20)] }
  let(:gilded_rose) { described_class.new(items) }

  describe "#update_quality" do
    it "does not change the name" do
      items = [InventoryItem.new("foo", 0, 0)]

      gilded_rose.update_quality()

      expect(items[0].name).to eq "foo"
    end

    it "decreases the #sell_in value" do
      expect { gilded_rose.update_quality() }.to change { items[0].sell_in }.by(-1)
    end

    it "decreases the #quality value" do
      expect { gilded_rose.update_quality() }.to change { items[0].quality }.by(-1)
    end

    it "#quality is never negative" do 
      items = [InventoryItem.new("foo", 0, 0)]

      GildedRose.new(items).update_quality()

      expect(items[0].quality).to be >= 0
    end

    it "“Aged Brie” increases in #quality the older it gets" do 
      items = [InventoryItem.new("Aged Brie", 10, 48)]

      gr = GildedRose.new(items)

      expect { gr.update_quality() }.to change { items[0].quality }.by(1)
    end

    it "#quality is never more than 50" do 
      items = [InventoryItem.new("Aged Brie", 10, 49)]

      gr = GildedRose.new(items)

      expect { gr.update_quality() }.to change { items[0].quality }.by(1)

      gr.update_quality()

      expect(items[0].quality).to eq(50)
    end

    it "#quality degrades twice as fast after sell by date has passed" do 
      items = [InventoryItem.new("foo", 0, 20)]

      gr = GildedRose.new(items)

      expect { gr.update_quality() }.to change { items[0].quality }.by(-2)
    end

    context "Sulfuras" do
      it "#sell_in and #quality does not decrease" do
        items = [InventoryItem.new("Sulfuras, Hand of Ragnaros", 20, 20)]

        GildedRose.new(items)

        expect(items[0].quality).to eq(20)
        expect(items[0].sell_in).to eq(20)
      end

      it "sell_in and #quality change for other items" do
        items = [
          InventoryItem.new("Sulfuras, Hand of Ragnaros", 20, 20),
          InventoryItem.new("foo", 20, 20)
        ]

        gr = GildedRose.new(items)

        expect(items[0].quality).to eq(20)
        expect(items[0].sell_in).to eq(20)
        
        expect { gr.update_quality() }.to change { items[1].sell_in }.by(-1)
      end
    end

    context "Backstage passses" do 
      it "#quality increases by 2 when #sell_in is 10 days or less" do
        items = [InventoryItem.new("Backstage passes to a TAFKAL80ETC concert", 10, 30)]

        gr = GildedRose.new(items)

        expect { gr.update_quality() }.to change { items[0].quality }.by(2)
      end

      it "#quality increases by 3 when #sell_in is 5 days or less" do
        items = [InventoryItem.new("Backstage passes to a TAFKAL80ETC concert", 5, 30)]

        gr = GildedRose.new(items)

        expect { gr.update_quality() }.to change { items[0].quality }.by(3)
      end

      it "#quality drops to 0 after concert when #sell_in is < 0" do
        items = [InventoryItem.new("Backstage passes to a TAFKAL80ETC concert", 0, 30)]

        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq(0)
      end
    end
  end
end
