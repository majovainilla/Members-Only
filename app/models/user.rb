# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_token
  has_secure_password
  has_many :posts

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }

  before_create :remember_me

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_me, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_me, nil)
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_me).is_password?(remember_token)
  end
end
