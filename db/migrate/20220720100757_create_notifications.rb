class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :from, :null => false
      t.integer :to, :null => false
      t.string :ntype, :null => false
      t.string :naction, :null => false
      t.string :non, :null => false
      t.boolean :seen, :default => false
      t.boolean :proceed, :default => false
      t.references :comment, null: true, index: true, foreign_key: {on_delete: :cascade}
      t.references :post, null: true, index: true, foreign_key: {on_delete: :cascade}
      t.timestamps
    end
  end
end
