class CreateProductFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :product_favorites do |t|

      t.timestamps
    end
  end
end
