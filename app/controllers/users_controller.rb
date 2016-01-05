class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'user/signup'
    else
      redirect '/goals'
    end
  end

  post '/signup' do
    if invalid_signup?
      erb :'user/signup', locals: @error_message
    else
      @user = User.new(params[:data])
      @user.before_save
      @user.save
      session[:user_id] = @user.id
      redirect to '/'
    end
  end

  get '/login' do

  end

  post '/login' do

  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

end
