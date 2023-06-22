class Order < ApplicationRecord
    has_many :cart_items
    has_many :items, through: :cart_items
    
    has_many :order_items, dependent: :destroy
    has_many :item, through: :order_items
    
    enum payment_method: { credit_card: 0, transfer: 1 }
    enum status: { waiting_payment:0, confirmation_payment: 1, under_process: 2, waiting_shipping: 3, completed_shipping: 4 }
    
    def amount_sum
        
    end
end
