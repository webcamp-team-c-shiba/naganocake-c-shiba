class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer
  
  def subtotal
      item.with_tax_price * amount
  end
      
    # 消費税
  def with_tax_price
      (price * 1.1).floor
  end
end
