class CreateMagicComments < ActiveRecord::Migration[5.2]
  def change
    create_table :magic_comments do |t|
      
      t.integer :user_id, null: false
      t.integer :magic_id, null: false
      t.text :comment

      t.timestamps
    end
  end
end
