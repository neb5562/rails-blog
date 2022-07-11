class Post < ApplicationRecord
  belongs_to :user, counter_cache: true 
  has_many :comments
  # has_many :post_categories, dependent: :delete_all
  # has_many :categories, through: :post_categories, counter_cache: true
  # before_save { validates_presence_of :categories }

  include Hashid::Rails
  
  # validates :title, presence: true,  length: { maximum: 255 }
  validates :text, presence: true,  length: { maximum: 65000 }
  validates :active, inclusion: { in: [ true, false ] }
  # validates :description, presence: true,  length: { maximum: 255 }
  # validates :post_categories, presence: true

  def next
    nxt ||= Post.where("id > ?", id).where(active: true).first
    nxt
  end

  def prev
    prv ||= Post.where("id < ?", id).where(active: true).last
    prv
  end

  def self.search(search)
    if search.present?
      Post.where('lower(title) LIKE ?', "%#{search.downcase}%").or(Post.where('lower(text) LIKE ?', "%#{search.downcase}%"))
    end
  end 


end
