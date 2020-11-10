class CreateMagics < ActiveRecord::Migration[5.2]
  def change
    create_table :magics do |t|

      t.timestamps
    end
  end
end
