class GoalsController < ApplicationController

  # INDEX
  get '/goals' do
    redirect_if_not_logged_in
    @goals = current_user.goals

    erb :'goals/goals'
  end

  # NEW GOAL
  get '/goals/new' do
    redirect_if_not_logged_in
    erb :'goals/new_goal'
  end

  post '/goals' do
    if Goal.valid_params?(params)
      current_user.create_goal_with_entries(params)
      redirect '/weekly_goal'
    else
      erb :'goals/new_goal', locals: {invalid_params: "Please fill in a title and at least one goal."}
    end
  end

  # WEEKLY GOAL
  get '/weekly_goal' do
    redirect_if_not_logged_in
    if current_user.weekly_goal.present?
      @entry = Goal.find(current_user.weekly_goal).entry
      erb :'goals/weekly_goal'
    else
      redirect '/goals/new'
    end
  end

  # DELETE GOAL
  post '/goals/:id/delete' do
    if logged_in?
      goal = Goal.find(params[:id])
      if goal.user_id == session[:user_id]
        goal.delete
        if current_user.weekly_goal == goal.id
          current_user.update(weekly_goal: nil)
        end
      end
      redirect '/goals'
    else
      redirect '/login'
    end
  end

end
