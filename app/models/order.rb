class Order < ApplicationRecord
    has_many :cart_items
    has_many :items, through: :cart_items
    
    has_many :order_items, dependent: :destroy
    has_many :items, through: :order_items
    
    enum payment_method: { credit_card: 0, transfer: 1 }
    enum order_status: { "入金待ち":0, "入金確認":1, "製作中":2, "発送準備中":3, "発送済":4 }
    enum product_status: { "着手不可": 0, "製作待ち": 1, "製作": 2, "製作完了": 3 }
end
