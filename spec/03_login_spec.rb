require 'spec_helper'

describe UsersController do

  describe "Login" do
    it 'loads the login page' do
        get '/login'
        expect(last_response.status).to eq(200)
    end

    it 'directs user to index' do
      user = User.create(username: "Tom", password: "brady")
      params = {
        :data => {
          :username => "Tom",
          :password => "brady"
        }
      }
      post '/login', params
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome,")
    end

    it 'does not let a user login without a username' do
      params = {
        :data => {
          :username => "",
          :password => "brady"
        }
      }
      post '/login', params
      expect(last_response.body).to include("Please fill in each field.")
    end

    it 'does not let a user login without a password' do
      params = {
        :data => {
          :username => "Tom",
          :password => ""
        }
      }
      post '/login', params
      expect(last_response.body).to include("Please fill in each field.")
    end

    it 'does not let a user sign up with a username that is taken' do
      user = User.new(username: "Tom", password: "brady")
      user.before_save
      user.save

      params = {
        :data => {
          :username => "Tom",
          :password => "brady"
        }
      }
      post '/signup', params
      expect(last_response.body).to include("Username is already taken.")
    end
  end
end
