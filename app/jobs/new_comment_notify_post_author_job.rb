class NewCommentNotifyPostAuthorJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Notification.create(non: "Post", from: args.first.user_id, to: args.first.post.user.id, ntype: "Comment", naction: "Create", comment_id: args.first.id, post_id: args.first.post.id) unless args.first.user_id == args.first.post.user.id
  end
end
