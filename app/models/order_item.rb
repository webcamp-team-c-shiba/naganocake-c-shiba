class OrderItem < ApplicationRecord
    belongs_to :item
    belongs_to :order
    
    enum status: { waiting:0, waiting_process: 1, under_process: 2, completed_process: 3 }
      # 消費税
  def with_tax_price
    (price * 1.1).floor
  end

  def subtotal
      with_tax_price * amount
  end
end
