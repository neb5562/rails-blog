class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user, null: false, foreign_key: {on_delete: :cascade}
      t.references :post, null: false, foreign_key: true
      t.integer :likes_count, default: 0
      t.integer :parent_id, null: true
      t.timestamps
    end
  end
end
