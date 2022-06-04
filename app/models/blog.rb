class Blog < ApplicationRecord
  belongs_to :user, counter_cache: true 
  has_many :comments
  has_many :blog_categories
  has_many :categories, through: :blog_categories, counter_cache: true

  include Hashid::Rails
  
  validates :blog_title, presence: true,  length: { maximum: 255 }
  validates :blog_text, presence: true,  length: { maximum: 65000 }
  validates :blog_description, presence: true,  length: { maximum: 255 }
  validate :atleast_one_is_checked
  def next
    nxt ||= Blog.where("id > ?", id).where(active: true).first
    nxt
  end

  def prev
    prv ||= Blog.where("id < ?", id).where(active: true).last
    prv
  end

  def atleast_one_is_checked
    errors.add(:base, "Select at least one category") if self.categories.blank?
  end
end
