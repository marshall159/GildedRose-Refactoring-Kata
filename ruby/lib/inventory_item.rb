class InventoryItem < Item 

    def decrease_sell_in
        self.sell_in -= 1
    end
end