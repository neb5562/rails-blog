class Category < ApplicationRecord
  has_many :post_categories
  has_many :posts, through: :post_categories, counter_cache: true 

  validates :name, presence: true, uniqueness: true, length: { maximum: 125 }
  before_save { |category| category.name = category.name.downcase.strip }
end
