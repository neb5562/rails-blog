class CreatePhones < ActiveRecord::Migration[7.0]
  def change
    create_table :phones do |t|
      t.string :phone, required: true, unique: true
      t.string :country, required: true
      t.references :user, null: false, index: true, foreign_key: {on_delete: :cascade}
      t.timestamps
    end
    add_index :phones, [:user_id, :phone], :unique => true
  end
end
