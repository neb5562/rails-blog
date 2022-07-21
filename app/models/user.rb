class User < ApplicationRecord
  rolify
  has_many :posts
  has_many :likes
  has_many :comments
  has_many :addresses
  has_many :phones
  has_many :notifications, class_name: 'Notification', foreign_key: 'to'
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fill: [100, 100]
  end

  has_settings do |s|
    s.key :settings, :defaults => { :user_post_color => '#3b82f680' }
    s.key :privacy, :defaults => { :user_email_notify_on_new_ip => 'false' }
  end

  include Hashid::Rails
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  devise :omniauthable, omniauth_providers: [:google_oauth2]

  validates :full_name, presence: true,  length: { minimum: 2, maximum: 255 }
  validates :username, presence: true,  length: { minimum: 4, maximum: 12 }
  validates :username, format: { without: /\s/ }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 

  after_create :assign_default_role
  # def after_confirmation
  #   UserMailer.with(user: self).welcome_email.deliver_later
  # end


  def phone?
    @phone
  end

  def admin?
    self.has_role? :admin
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(
           full_name: data['name'],
           email: data['email'],
           username: data['email'].split("@").first.gsub(/[^0-9a-zA-Z]/i, '').downcase[0,12],
           password: Devise.friendly_token[0,20]
        )
    end
    user
  end

  private

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

end
