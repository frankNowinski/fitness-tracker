class GoalsController < ApplicationController

  get '/goals' do
    redirect_if_not_logged_in
    @user = current_user
    erb :'goals/goals'
  end

  get '/goals/new' do
    redirect_if_not_logged_in
    erb :'goals/new_goal'
  end

  post '/goals' do
    user = current_user
    user.create_goal_with_entries(params)
    redirect '/current_goal'
  end

  get '/current_goal' do
    redirect_if_not_logged_in
    @current_goal = current_user.goals.last
    erb :'goals/current_goal'
  end

  get '/goals/:id' do
    redirect_if_not_logged_in
    @entry = Goal.find(params[:id]).entry
    erb :'goals/show_goal'
  end

  get '/goals/:id/edit' do
    redirect_if_not_logged_in
    @goal = Goal.find(params[:id])
    binding.pry
    erb :'goals/edit_goal'
  end

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
