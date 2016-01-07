class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'user/signup'
    else
      redirect '/weekly_goal'
    end
  end

  post '/signup' do
    error_message = User.invalid_signup?(params)
    if error_message.present?
      erb :'user/signup', locals: error_message
    else
      @user = User.new(params[:data])
      @user.before_save
      @user.save
      session[:user_id] = @user.id
      redirect to '/weekly_goal'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/weekly_goal'
    else
      erb :index
    end
  end

  post '/login' do
    if User.emtpy_field?(params)
      erb :index, locals: {empty_field: "Please fill in both a username and a password."}
    else
      @user = User.find_by(username: params[:data][:username])
      if @user && @user.authenticate(params[:data][:password])
        session[:user_id] = @user.id
        redirect '/weekly_goal'
      else
        erb :index, locals: {invalid_login: "Invalid username or password."}
      end
    end
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
