class InventoryItem < Item 
  
    def initialize(name, sell_in, quality)
        super(name, sell_in, quality)
    end

    def decrease_sell_in
        self.sell_in -= 1
    end
end