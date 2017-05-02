class User < ActiveRecord::Base
  has_secure_password
  has_many :purchases, :foreign_key => "user_id", :class_name => "Purchase"
  has_many :buyers, :through => :purchases 

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 5 }, on: [:create]
  
  before_save :email_lowercase

  def email_lowercase
    email.downcase!
  end

end
