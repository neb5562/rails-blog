class User < ApplicationRecord
  has_many :blogs

  include Hashid::Rails
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, presence: true,  length: { minimum: 2, maximum: 255 }
  validates :username, presence: true,  length: { minimum: 4, maximum: 12 }
  validates :username, format: { without: /\s/ }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  # validates :password, presence: true, :confirmation =>true
end
