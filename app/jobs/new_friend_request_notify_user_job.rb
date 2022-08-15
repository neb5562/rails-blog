class NewFriendRequestNotifyUserJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Notification.create(non: "Friend", from: args.first.user_id, to: args.first.to_user_id, ntype: "Request", naction: "Create",  request_id: args.first.id)
  end
end
