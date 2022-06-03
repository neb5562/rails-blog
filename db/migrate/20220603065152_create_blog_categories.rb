class CreateBlogCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_categories do |t|
      t.timestamps
      t.references :blog, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
    end
  end
end
