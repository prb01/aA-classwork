class User < ApplicationRecord
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :password, length: { minimum: 6 }, allow_nil: true
  before_validation :ensure_session_token

  has_many :cats
  has_many :cat_rental_requests
  has_many :requests_to_rent_my_cat,
    through: :cats,
    source: :rental_requests

  attr_reader :password

  def self.find_by_credentials(user_params)
    user = User.find_by(username: user_params[:username])
    return user if user && user.is_password?(user_params[:password])
    nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
