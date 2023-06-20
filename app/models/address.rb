class Address < ApplicationRecord
    belongs_to :customer
    
    validates :postcode, presence: true
    validates :address, presence: true
    validates :name, presence: true

  def address_display
  '〒' + postal_code + ' ' + address + ' ' + name
  end

end
