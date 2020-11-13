class AddColumnUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_name, :string, null: false, default: ""
    change_column_default :users, :discriotion, from: "", to: "よろしくお願いします！"
  end
end
