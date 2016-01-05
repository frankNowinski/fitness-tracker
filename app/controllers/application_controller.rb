require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "ipickthingsup"
  end

  get '/' do
    erb :index
  end

  helpers do
    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login?error=You have to be logged in to do that"
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def invalid_signup?
      if missing_field?
        @error_message = {missing_field: "Please fill in each field."}
      elsif taken_username?
        @error_message = {taken_username: "Username is already taken."}
      end
    end

    def missing_field?
      params[:data].values.any?{|x| x == ""}
    end

    def taken_username?
      User.find_by(username: params[:data][:username].downcase).present?
    end
  end
end
