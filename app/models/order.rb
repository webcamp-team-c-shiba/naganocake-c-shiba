class Order < ApplicationRecord
    has_many :cart_items
    has_many :items, through: :cart_items
    
    has_many :order_items, dependent: :destroy
    has_many :items, through: :order_items
    
    belongs_to :customer
    enum payment_method: { credit_card: 0, transfer: 1 }
    enum status: { "入金待ち":0, "入金確認":1, "製作中":2, "発送準備中":3, "発送済":4 }
end
