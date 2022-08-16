class User < ApplicationRecord
  rolify
  has_many :posts
  has_many :likes
  has_many :comments
  has_many :addresses
  has_many :phones
  has_many :subscriptions
  has_many :payments
  has_many :requests, foreign_key: 'to_user_id'
  has_many :notifications, -> { order(created_at: :desc) }, class_name: 'Notification', foreign_key: 'to'
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fill: [100, 100]
  end

  has_settings do |s|
    s.key :settings, :defaults => { :user_post_color => '#3b82f680' }
    s.key :privacy, :defaults => { :user_email_notify_on_new_ip => 'false' }
  end

  include Hashid::Rails
  # Include default devise modules. Others available are::database_authenticatable, :confirmable
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

  def friends
    Friend.where("first_id = ? OR second_id = ?", self.id, self.id)
  end

  def phone?
    @phone
  end

  def admin?
    self.has_role? :admin
  end

  def premium?
    @last_sub = subscriptions.last
    return false if @last_sub.end_at.nil?
    @last_p = @last_sub.payments.last
    return false if @last_p.nil?
    @last_sub.end_at > Time.now && @last_p.status == true
    puts @last_sub.inspect
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
        return { user: user, new_user: true }
    end
   { user: user, new_user: false }
  end

  def request_sent? user
    Request.where(to_user_id: user.id, user_id: self.id).exists?
  end

  def friend? user
    Friend.where(first_id: user.id, second_id: self.id).exists?
  end

  private

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  # def after_confirmation
  #   welcome_email
  # end

end
