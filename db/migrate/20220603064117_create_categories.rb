class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.integer :blogs_count
      t.timestamps
    end

    Category.create(name: 'uncategorised')
  end
end
