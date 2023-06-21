class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :shipping_fee
      t.integer :payment
      t.integer :payment_method
      t.string :postcode
      t.string :address
      t.string :name
      t.integer :status

      t.timestamps
    end
  end
end
