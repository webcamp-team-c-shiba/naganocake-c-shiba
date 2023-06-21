class Order < ApplicationRecord
    has_many :cart_items
    has_many :items, through: :cart_items
    
    enum payment_method: { credit_card: 0, transfer: 1 }

end
