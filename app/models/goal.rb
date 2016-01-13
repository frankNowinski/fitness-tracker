class Goal < ActiveRecord::Base
  belongs_to :user
  has_one :entry

  def self.valid_params?(params)
    params[:title].present? && supplied_entries?(params)
  end

  def self.supplied_entries?(params)
    params[:entries].values.any?{|entry| entry != ""}
  end

  def self.create_goal_for_user(current_user, params)
    goal = current_user.goals.create(title: params[:title])
    goal.create_entry(params[:entries])

    if params[:weekly_goal] == "1"
      self.update(weekly_goal_id: goal.id)
    end
  end

end
