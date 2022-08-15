class Friend < ApplicationRecord
  belongs_to :user, foreign_key: 'first_id'
end
