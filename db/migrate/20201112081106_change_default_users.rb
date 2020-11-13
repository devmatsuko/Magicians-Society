class ChangeDefaultUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :first_name, nil
    change_column_default :users, :last_name_kana, nil
    change_column_default :users, :first_name_kana, nil
    change_column_default :users, :postcode, nil
    change_column_default :users, :address, nil
    change_column_default :users, :phone_number, nil
    change_column_default :users, :display_name, nil
    change_column_default :users, :last_name, nil
  end
end
