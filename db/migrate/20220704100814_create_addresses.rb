class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street, null: true
      t.string :number, null: true
      t.string :region, null: true
      t.string :region_code, null: true
      t.string :county, null: true
      t.string :country, null: true
      t.string :country_code, null: true
      t.string :administrative_area, null: true
      t.string :latitude, null: true
      t.string :longitude, null: true
      t.string :label, null: true
      t.references :user, null: false, index: true, foreign_key: {on_delete: :cascade}
      t.timestamps
    end
  end
end
