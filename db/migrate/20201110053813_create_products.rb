class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|

      t.integer :user_id, null: false
      t.integer :genre_id, null: false
      t.string :name, null: false
      t.text :explanation, null: false
      t.integer :product_status, null: false
      t.integer :price, null: false
      t.boolean :is_sale, null: false, default: true
      t.string :image_id, null: false
      t.integer :shipping_method, null: false
      t.integer :shipping_date, null: false
      t.integer :postage_status, null: false
      t.float :rate

      t.timestamps
    end
  end
end
