class CreateBlogCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_categories do |t|
      t.timestamps
      t.references :blog, null: false, index: true, foreign_key: {on_delete: :cascade}
      t.references :category, null: false, index: true, foreign_key: {on_delete: :cascade}
    end
  end
end
