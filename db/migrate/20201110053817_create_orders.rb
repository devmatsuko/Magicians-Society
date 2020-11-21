class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.integer :user_id, null: false
      t.integer :product_id, null: false
      t.integer :pay_method, null: false
      t.integer :order_status, null: false, default: 0
      t.integer :total_price, null: false
      t.integer :postage, null: false
      t.string :postcode, null: false
      t.string :address, null: false
      t.string :name, null: false


      t.timestamps
    end
  end
end
