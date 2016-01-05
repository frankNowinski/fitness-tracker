class User < ActiveRecord::Base
  has_many :goals
  has_secure_password

  def before_save
    username.downcase!
  end
end
