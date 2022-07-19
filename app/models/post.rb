class Post < ApplicationRecord
  resourcify
  belongs_to :user, counter_cache: true 
  has_many :comments
  has_many :likes

  include Hashid::Rails

  validates :text, presence: true,  length: { maximum: 65000 }
  validates :active, inclusion: { in: [ true, false ] }

  def self.search(search)
    if search.present?
      Post.where('lower(title) LIKE ?', "%#{search.downcase}%").or(Post.where('lower(text) LIKE ?', "%#{search.downcase}%"))
    end
  end 

  def active?
    !!self.active
  end

end
