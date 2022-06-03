class Category < ApplicationRecord
  has_many :blog, through: :blog_categories, counter_cache: true 

  validates :name, presence: true,  length: { maximum: 125 }
end
