class UniqueAddress < ActiveRecord::Migration[7.0]
  def change
    add_index :addresses, [:latitude, :longitude, :user_id], :unique => true
  end
end
