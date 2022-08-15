class CraeteTableFriends < ActiveRecord::Migration[7.0]
  def change
    create_table :friends do |t|
      t.boolean :following, default: true
      t.references :first, foreign_key: { to_table: 'users', on_delete: :cascade}
      t.references :second, foreign_key: { to_table: 'users' , on_delete: :cascade}
      t.timestamps
    end
  end
end
