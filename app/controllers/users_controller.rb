class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'user/signup'
    else
      redirect '/goals'
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
      redirect to '/'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/goals'
    else
      erb :'user/login'
    end
  end

  post '/login' do
    if User.emtpy_field?(params)
      erb :'user/login', locals: {missing_field: "Please fill in both a username and a password."}
    else
      @user = User.find_by(username: params[:data][:username])
      if @user && @user.authenticate(params[:data][:password])
        session[:user_id] = @user.id
        redirect '/index'
      else
        erb :'user/login', locals: {invalid_login: "Invalid username or password."}
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
