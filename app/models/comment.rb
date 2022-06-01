class Comment < ApplicationRecord
  belongs_to :user, :counter_cache => true
  belongs_to :blog, :counter_cache => true
  has_many :likes
  validates :body, presence: true,  length: { minimum: 2, maximum: 555 }
  validates :body, format: { without: /\s/ }

end
