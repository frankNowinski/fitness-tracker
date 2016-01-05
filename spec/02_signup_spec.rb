describe UsersController do

  describe "Signup" do
    it 'loads the signup page' do
        get '/signup'
        expect(last_response.status).to eq(200)
    end

    it 'signup directs user to index' do
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
      expect(last_response.body).to include("Please fill in both a username and a password.")
    end

    it 'does not let a user sign up without a password' do
      params = {
        :data => {
          :username => "Tom",
          :password => ""
        }
      }
      post '/signup', params
      expect(last_response.body).to include("Please fill in both a username and a password.")
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
