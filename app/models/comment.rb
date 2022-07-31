class Comment < ApplicationRecord
  belongs_to :user, :counter_cache => true
  belongs_to :post, :counter_cache => true
  has_many :likes
  belongs_to :notification, optional: true
  belongs_to :parent,  class_name: "Comment", optional: true, counter_cache: :count_of_replies #-> requires "parent_id" column
  has_many   :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy

  validates :body, presence: true,  length: { minimum: 2, maximum: 555 }
  before_validation :strip_whitespace

  after_commit :notify_post_author, on: :create

  private
  
  def strip_whitespace
    self.body = self.body.strip unless self.body.nil?
  end

  def notify_post_author
    NewCommentNotifyPostAuthorJob.set(wait_until: Time.now + 1.minutes).perform_later self
  end
  
end
