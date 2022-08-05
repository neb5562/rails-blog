class CreateUserFriends < ActiveRecord::Migration[7.0]
  def change
    create_table :friends do |t|
      t.boolean :following, default: true
      t.references :user, null: true, index: true, foreign_key: {on_delete: :cascade}
      t.integer :friend_id, null: false
      t.timestamps
    end
  end
end
