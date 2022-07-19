class Like < ApplicationRecord
  belongs_to :user, counter_cache: true 
  belongs_to :comment, optional: true, counter_cache: true 
  belongs_to :post, optional: true, counter_cache: true 
end
