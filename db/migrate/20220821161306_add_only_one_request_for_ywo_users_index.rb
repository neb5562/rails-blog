class AddOnlyOneRequestForYwoUsersIndex < ActiveRecord::Migration[7.0]
  def change
    add_index :requests, [:user_id, :to_user_id], unique: true
  end
end
