class User < ActiveRecord::Base
  validates :name,  presence: true, length: { maximum: 10 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #唯一性验证无法真正保证唯一性。
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  #email 不区分大小写
  before_save { self.email = email.downcase }

  validates :password, length: { minimum: 6 }
  has_secure_password

end
