class User < ActiveRecord::Base
  has_many :goals
  has_secure_password

  def create_goal_with_entries(params)
    goal = self.goals.create(title: params[:title])
    goal.entry = Entry.new(params[:entries])

    binding.pry
    if params[:weekly_goal] == "1"
      self.update(weekly_goal: goal.entry)
    end
  end

  # def wk_goal
  #   Goal.find(self.weekly_goal).entry
  # end

  def before_save
    username.downcase!
  end

  def self.invalid_signup?(params)
    if emtpy_field?(params)
      {emtpy_field: "Please fill in both a username and a password."}
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
