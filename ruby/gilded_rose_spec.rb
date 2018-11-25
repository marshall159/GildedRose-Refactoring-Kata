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
  end

end
