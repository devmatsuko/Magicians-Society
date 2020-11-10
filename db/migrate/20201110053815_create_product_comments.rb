class CreateProductComments < ActiveRecord::Migration[5.2]
  def change
    create_table :product_comments do |t|

      t.timestamps
    end
  end
end
