class User < ApplicationRecord
  has_many :addresses, as: :addressable
  accepts_nested_attributes_for :addresses
  enum user_type: { admin: 0, customer: 1, vendor: 2 }
end
