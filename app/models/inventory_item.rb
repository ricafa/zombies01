class InventoryItem < ApplicationRecord
  belongs_to :survivor, required: false
  belongs_to :item
end
