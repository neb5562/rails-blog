class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.boolean :status, default: false
      t.string :payment_type, null: false
      t.string :transaction_id, null: true
      t.references :user, null: true, index: true, foreign_key: {on_delete: :cascade}
      t.references :subscription, null: true, index: true, foreign_key: {on_delete: :cascade}
      t.timestamps
    end
  end
end
