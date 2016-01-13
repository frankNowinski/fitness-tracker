class GoalsController < ApplicationController
  before "/goals*" do
    redirect_if_not_logged_in
  end

  # INDEX
  get '/goals' do
    @goals = current_user.goals
    erb :'goals/goals'
  end

  # NEW GOAL
  get '/goals/new' do
    erb :'goals/new_goal'
  end

  post '/goals' do
    if Goal.valid_params?(params)
      Goal.create_for_user(current_user, params)
      redirect "/entry/#{current_user.last_entry}"
    else
      erb :'goals/new_goal', locals: {invalid_params: "Please fill in a title and at least one goal."}
    end
  end

  # WEEKLY GOAL
  get '/weekly_goal' do
    @entry = current_user.weekly_goal
    if @entry.present?
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
        goal.destroy
        current_user.reset_weekly_goal(goal.id)
      end
      redirect '/goals'
    else
      redirect '/login'
    end
  end

end
