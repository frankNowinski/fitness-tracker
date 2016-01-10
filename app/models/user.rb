class User < ActiveRecord::Base
  has_many :goals
  has_secure_password

  # Instance Methods
  def create_goal_with_entries(params)
    goal = self.goals.create(title: params[:title])
    goal.entry = Entry.new(params[:entries])

    if params[:weekly_goal] == "1"
      self.update(weekly_goal_id: goal.id)
    end
  end

  def weekly_goal
    if self.weekly_goal_id.present?
      Goal.find(self.weekly_goal_id).entry
    end
  end

  def last_entry
    self.goals.last.entry.id
  end

  def reset_weekly_goal(goal_id)
    if weekly_goal_id == goal_id
      update(weekly_goal_id: nil)
    end
  end

  def before_save
    username.downcase!
  end

  # Class Methods
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
