class AddAddressesCountToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :addresses_count, :integer
  end
end