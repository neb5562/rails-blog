class Comment < ApplicationRecord
  belongs_to :user, :counter_cache => true
  belongs_to :post, :counter_cache => true
  has_many :likes

  belongs_to :parent,  class_name: "Comment", optional: true #-> requires "parent_id" column
  has_many   :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy

  validates :body, presence: true,  length: { minimum: 2, maximum: 555 }
  before_validation :strip_whitespace

  private
  
  def strip_whitespace
    self.body = self.body.strip unless self.body.nil?
  end
  
end
