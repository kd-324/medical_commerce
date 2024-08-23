class Order < ApplicationRecord
  belongs_to :user
  has_one :addresses, as: :addressable
  accepts_nested_attributes_for :addresses
  enum status: { in_progress: 0, completed: 1, canceled: 2 }
end
