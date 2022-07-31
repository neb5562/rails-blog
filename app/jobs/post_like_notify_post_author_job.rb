class PostLikeNotifyPostAuthorJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Notification.create(non: "Post", from: args.first.user_id, to: args.first.post.user.id, ntype: "Like", naction: "Create",  post_id: args.first.post.id) unless args.first.user_id == args.first.post.user.id
  end
end
