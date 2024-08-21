class Item < ApplicationRecord
  belongs_to :order
  belongs_to :sku
  enum status: { in_cart: 0, shipped: 1, delivered: 2 }
end
