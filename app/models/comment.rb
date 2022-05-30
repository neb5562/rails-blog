class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog
  validates :body, presence: true,  length: { minimum: 2, maximum: 555 }
  validates :body, format: { without: /\s/ }

end
