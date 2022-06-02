class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs do |t|
      t.string :blog_title
      t.text :blog_text
      t.integer :comments_count
      t.timestamps
    end
  end
end
