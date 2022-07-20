class CommentLikeNotifyCommentAuthorJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Notification.create(non: "Comment", from: args.first.user_id, to: args.first.comment.user.id, ntype: "Like", naction: "Create", comment_id: args.first.comment.id, post_id: args.first.comment.post.id)
  end
end
