class AddActiveDescriptionToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :active, :boolean, default: false
    add_column :blogs, :blog_description, :string
  end
end
