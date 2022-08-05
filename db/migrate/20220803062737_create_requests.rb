class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.boolean :seen, default: false
      t.integer :to_user_id, null: false
      t.references :user, null: true, index: true, foreign_key: {on_delete: :cascade}
      t.timestamps
    end
  end
end
