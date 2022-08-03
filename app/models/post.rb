class Post < ApplicationRecord
  resourcify
  belongs_to :user, counter_cache: true 
  has_many :comments
  has_many :likes
  belongs_to :notification, optional: true
  include Hashid::Rails

  scope :active, -> { where(active: true) }

  validates :text, presence: true,  length: { maximum: 65000 }
  validates :active, inclusion: { in: [ true, false ] }

  def self.search(search)
    if search.present?
      Post.where('lower(text) LIKE ?', "%#{search.downcase}%")#.or(Post.where('lower(text) LIKE ?', "%#{search.downcase}%"))
    end
  end 

  def active?
    !!self.active
  end

end
