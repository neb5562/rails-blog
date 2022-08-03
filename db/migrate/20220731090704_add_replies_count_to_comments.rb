class AddRepliesCountToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :count_of_replies, :integer, default: 0
  end
end
