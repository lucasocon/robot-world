class Order < ActiveRecord::Base
  has_one :item

  enum status: [:delivered, :pending]
end
