require 'bcrypt'
# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  username        :string           not null
#

class User < ApplicationRecord

  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :session_token, presence: true, uniqueness: true
  validates :password_digest, :email, presence: true

  after_initialize :ensure_session_token
  attr_reader :password

  # ===================================
  # ASSOCIATIONS
  # ===================================
  has_many :music_groups,
    primary_key: :id,
    foreign_key: :member_id,
    class_name: :Band


  # ===================================
  # CLASS METHODS
  # ===================================
  def self.generate_session_token
    @session_token ||= SecureRandom.urlsafe_base64
  end


  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    user && user.is_password?(password) ? user : nil
  end



  # ===================================
  # INSTANCE METHODS
  # ===================================

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    User.generate_session_token
    self.save!
    self.session_token
  end


end
