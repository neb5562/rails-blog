class Blog < ApplicationRecord
  belongs_to :user, counter_cache: true 
  has_many :comments

  include Hashid::Rails
  
  validates :blog_title, presence: true,  length: { maximum: 255 }
  validates :blog_text, presence: true,  length: { maximum: 65000 }
  validates :blog_description, presence: true,  length: { maximum: 255 }

  def next
    nxt ||= Blog.where("id > ?", id).where(active: true).first
    nxt
  end

  def prev
    prv ||= Blog.where("id < ?", id).where(active: true).last
    prv
  end
end
