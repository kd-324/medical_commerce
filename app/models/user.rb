class User < ApplicationRecord
  enum type: { admin: 0, customer: 1, vendor: 2 }
end
