class CreateMagicComments < ActiveRecord::Migration[5.2]
  def change
    create_table :magic_comments do |t|

      t.timestamps
    end
  end
end
