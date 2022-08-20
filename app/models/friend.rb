class Friend < ApplicationRecord
  belongs_to :first, class_name: "User", foreign_key: "first_id"
  belongs_to :second, class_name: "User", foreign_key: "second_id"
end
