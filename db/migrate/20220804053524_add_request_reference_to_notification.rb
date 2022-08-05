class AddRequestReferenceToNotification < ActiveRecord::Migration[7.0]
  def change
    add_reference :notifications, :request, null: true, foreign_key: {on_delete: :cascade}
  end
end
