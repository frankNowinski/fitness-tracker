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
    user = current_user
    user.create_goal_with_entries(params)

    redirect '/weekly_goal'
  end

  # WEEKLY GOAL
  get '/weekly_goal' do
    redirect_if_not_logged_in
    if current_user.goals.present?
      @entry = current_user.goals.last.entry
      erb :'goals/weekly_goal'
    else
      redirect '/goals/new'
    end
  end

  # DELETE GOAL
  post '/goals/:id/delete' do
    if logged_in?
      @goal = Goal.find(params[:id])
      if @goal.user_id == session[:user_id]
        @goal.delete
      end
      redirect '/goals'
    else
      redirect '/login'
    end
  end

end
