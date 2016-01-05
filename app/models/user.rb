class User < ActiveRecord::Base
  has_many :goals
  has_secure_password

  def before_save
    username.downcase!
  end

  def self.invalid_signup?(params)
    if emtpy_field?(params)
      {emtpy_field: "Please fill in each field."}
    elsif taken_username?(params)
      {taken_username: "Username is already taken."}
    end
  end

  def self.emtpy_field?(params)
    params[:data].values.any?{|x| x == ""}
  end

  def self.taken_username?(params)
    User.find_by(username: params[:data][:username].downcase).present?
  end
end
