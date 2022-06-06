class Category < ApplicationRecord
  has_many :blog_categories
  has_many :blogs, through: :blog_categories, counter_cache: true 

  validates :name, presence: true, uniqueness: true, length: { maximum: 125 }
  before_save { |category| category.name = category.name.downcase.strip }
end
