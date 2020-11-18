class CreateMagics < ActiveRecord::Migration[5.2]
  def change
    create_table :magics do |t|

      t.integer :user_id, null: false
      t.string :image_id, default: ""
      t.string :title
      t.string :video
      t.text :body

      t.timestamps

    end
  end
end
