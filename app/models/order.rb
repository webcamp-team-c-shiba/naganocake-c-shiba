class Order < ApplicationRecord
    
    has_many :order_items, dependent: :destroy
    has_many :item, through: :order_items
    
    enum payment_method: { credit_card: 0, transfer: 1 }
    
end
