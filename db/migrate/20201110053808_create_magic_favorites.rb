class CreateMagicFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :magic_favorites do |t|
      
      t.integer :user_id, null: false
      t.integer :magic_id, null: false
      
      t.timestamps
    end
  end
end
