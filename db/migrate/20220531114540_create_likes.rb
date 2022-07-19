class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :comment, null: true, default: nil
      t.references :post, null: true, default: nil
      t.timestamps
    end
  end
end
