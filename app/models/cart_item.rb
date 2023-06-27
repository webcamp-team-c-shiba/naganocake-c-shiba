class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer
  
  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
  
  def subtotal
      item.with_tax_price * amount
  end
  
end
