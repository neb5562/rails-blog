class Request < ApplicationRecord
  attr_accessor :from
  attr_accessor :to
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :notification, optional: true

  after_commit :notify_user, on: :create


  private

  def notify_user
    NewFriendRequestNotifyUserJob.set(wait_until: Time.now).perform_later self
  end
end
