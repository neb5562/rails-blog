class Like < ApplicationRecord
  belongs_to :user, counter_cache: true 
  belongs_to :comment, optional: true, counter_cache: true 
  belongs_to :post, optional: true, counter_cache: true 

  after_commit :notify_comment_author, on: :create, :if=> :comment?
  after_commit :notify_post_author, on: :create, :if=> :post?

  private

  def comment?
    self.comment_id
  end

  def post?
    self.post_id
  end

  def notify_comment_author
    CommentLikeNotifyCommentAuthorJob.set(wait_until: Time.now + 1.minutes).perform_later self
  end

  def notify_post_author
    PostLikeNotifyPostAuthorJob.set(wait_until: Time.now + 1.minutes).perform_later self
  end
end
