class Comment < ApplicationRecord
  belongs_to :user, :counter_cache => true
  belongs_to :blog, :counter_cache => true
  has_many :likes
  validates :body, presence: true,  length: { minimum: 2, maximum: 555 }
  before_validation :strip_whitespace

  private
  
  def strip_whitespace
    self.body = self.body.strip unless self.body.nil?
  end
  
end
