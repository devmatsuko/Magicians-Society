class AddColumnMagics < ActiveRecord::Migration[5.2]
  def change
    add_column :magics, :video, :string
    add_column :magics, :title, :string
  end
end
