class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :name, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.decimal :price, :precision => 8, :scale => 2
      t.references :user, null: true, index: true, foreign_key: {on_delete: :cascade}      
      t.timestamps
    end
    add_index :subscriptions, [:user_id, :phone], :unique => true
  end
end
