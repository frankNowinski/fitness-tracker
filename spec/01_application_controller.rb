require 'spec_helper'

describe ApplicationController do

  describe "Homepage" do
    it 'loads the homepage' do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome to Fitness Tracker")
      expect(last_response.body).to include("Signup")
      expect(last_response.body).to include("Login")
    end
  end

  describe "Signup" do
    it 'loads the signup page' do
        get '/signup'
        expect(last_response.status).to eq(200)
    end

    it 'signup directs user to twitter index' do
      params = {
        :data => {
          :username => "Tom",
          :password => "brady"
        }
      }
      post '/signup', params
      expect(last_response.location).to include("/")
    end

    it 'does not let a user sign up without a username' do
      params = {
        :data => {
          :username => "",
          :password => "brady"
        }
      }
      post '/signup', params
      expect(last_response.body).to include("Please fill in each field.")
    end

    it 'does not let a user sign up without a password' do
      params = {
        :data => {
          :username => "Tom",
          :password => ""
        }
      }
      post '/signup', params
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
