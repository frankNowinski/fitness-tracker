class GoalsController < ApplicationController

  # INDEX
  get '/goals' do
    redirect_if_not_logged_in
    @user = current_user

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

    redirect '/current_goal'
  end

  # CURRENT GOAL
  get '/current_goal' do
    redirect_if_not_logged_in
    @entry = current_user.goals.last.entry
    if @entry.present?
      erb :'goals/current_goal'
    else
      redirect '/goals/new'
    end
  end

  # SHOW GOAL
  get '/goals/:id' do
    redirect_if_not_logged_in
    @entry = Goal.find(params[:id]).entry

    erb :'goals/show_goal'
  end

  # UPDATE GOAL
  get '/goals/:id/update' do
    redirect_if_not_logged_in
    @goal = Goal.find(params[:id])

    erb :'goals/update_goal'
  end

  post '/goals/:id/update' do
    goal = Goal.find(params[:id])
    goal.update_goal(params)

    redirect "/goals/#{goal.id}"
  end

  # EDIT GOAL
  get '/goals/:id/edit' do
    redirect_if_not_logged_in
    @entry = Goal.find(params[:id]).entry

    erb :'goals/edit_goal'
  end

  post '/goals/:id/edit' do
    Goal.find(params[:id]).update(title: params[:title])
    entry = Goal.find(params[:id]).entry
    entry.update(params[:entries])

    redirect "/goals/#{params[:id]}"
  end

  # DELETE GOAL
  post '/goals/:id/delete' do
    if logged_in?
      @goal = Goal.find(params[:id])
      if @goal.user_id == session[:user_id]
        @goal.delete
      end
      redirect '/current_goal'
    else
      redirect '/login'
    end
  end

end
