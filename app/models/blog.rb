class Blog < ApplicationRecord
  belongs_to :user, counter_cache: true 
  has_many :comments
  has_many :blog_categories, dependent: :delete_all
  has_many :categories, through: :blog_categories, counter_cache: true
  before_save { validates_presence_of :categories }

  include Hashid::Rails
  
  validates :blog_title, presence: true,  length: { maximum: 255 }
  validates :blog_text, presence: true,  length: { maximum: 65000 }
  validates :blog_description, presence: true,  length: { maximum: 255 }
  validates :blog_categories, presence: true

  def next
    nxt ||= Blog.where("id > ?", id).where(active: true).first
    nxt
  end

  def prev
    prv ||= Blog.where("id < ?", id).where(active: true).last
    prv
  end

  def self.search(search)
    if search.present?
      Blog.where('blog_title LIKE ?', "%#{search}%").or(Blog.where('blog_text LIKE ?', "%#{search}%"))
    end
  end 


end
