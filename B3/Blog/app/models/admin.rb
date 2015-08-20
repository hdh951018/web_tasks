require 'digest/sha2'
class Admin < ActiveRecord::Base
  has_many :posts 
  has_many :comments
  has_many :feedbacks
  validates :username,presence: {value: true,message: "请输入用户名"}, 
    uniqueness:  {value: true,message: "用户名已存在"}, 
    length: { minimum: 6,maximum: 16,message: "用户名长度必须在6—16个字符之间" },
    format: { with: /\A[a-z][0-9a-z]+\Z/,
      message: "用户名只能由数字和小写字母组成，且开头不能为数字" }

  validates :password,confirmation: {value: true,message: "两次输入密码不一致"},
    length:{minimum: 6,maximum: 16,message: "密码长度必须在6-16个字符之间"}


  validates :nickname,presence: {value: true, message: "昵称不能为空"},
    length: {minimum: 2,maximum: 10,message: "昵称长度必须在2-10个字符之间"}
  attr_accessor :password_confirmation
  attr_reader :password
  validate :password_must_be_present

  def Admin.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "wibble" + salt)
  end

  def password=(password)
    @password = password

    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password,salt)
    end
  end

  def Admin.authenticate(username,password)
    if admin = find_by_username(username)
      if admin.hashed_password == encrypt_password(password,admin.salt)
        admin
      end
    end
  end

  private
    def generate_salt
      self.salt = self.object_id.to_s + rand.to_s
    end

    def password_must_be_present
      errors.add(:password,"请输入密码") unless hashed_password.present?
    end

end
