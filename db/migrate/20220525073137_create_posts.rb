class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :text
      t.integer :comments_count, default: 0
      t.integer :likes_count, default: 0
      t.timestamps
    end
  end
end
