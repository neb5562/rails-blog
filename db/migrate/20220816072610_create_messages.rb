class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :body, null: false
      t.boolean :seen, default: false
      t.datetime :seen_at, null: true, default: nil
      t.references :send, foreign_key: { to_table: 'users', on_delete: :cascade}
      t.references :receive, foreign_key: { to_table: 'users' , on_delete: :cascade}
      t.timestamps
    end
  end
end
