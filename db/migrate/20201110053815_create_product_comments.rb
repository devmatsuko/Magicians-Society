class CreateProductComments < ActiveRecord::Migration[5.2]
  def change
    create_table :product_comments do |t|
      
      t.integer :user_id, null: false
      t.integer :product_id, null: false
      t.text :comment, null: false
      t.float :rate, null: false

      t.timestamps
    end
  end
end
