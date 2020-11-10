class CreateMagicFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :magic_favorites do |t|

      t.timestamps
    end
  end
end
