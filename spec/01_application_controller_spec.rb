require 'spec_helper'

describe ApplicationController do

  describe 'Homepage' do
    it 'loads the homepage' do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome to Fitness Tracker")
      expect(last_response.body).to include("Signup")
      expect(last_response.body).to include("Login")
    end
  end

  describe 'Logout' do
    it 'does not let a user logout if not logged in' do
      get '/logout'
      expect(last_response.location).to include("/")
    end
  end
end
