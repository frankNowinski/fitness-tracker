describe UsersController do

  describe 'Login' do
    it 'loads the login page' do
        get '/login'
        expect(last_response.status).to eq(200)
    end

    it 'directs user to index' do
      user = User.create(username: "tom", password: "brady")
      params = {
        :data => {
          :username => "tom",
          :password => "brady"
        }
      }
      post '/login', params
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_response.status).to eq(302)
    end

    it 'does not let a user login without a username' do
      params = {
        :data => {
          :username => "",
          :password => "brady"
        }
      }
      post '/login', params
      expect(last_response.body).to include("Please fill in both a username and a password.")
    end

    it 'does not let a user login without a password' do
      params = {
        :data => {
          :username => "tom",
          :password => ""
        }
      }
      post '/login', params
      expect(last_response.body).to include("Please fill in both a username and a password.")
    end

    it 'does not let a user sign up with a username that is taken' do
      user = User.new(username: "tom", password: "brady")
      user.before_save
      user.save

      params = {
        :data => {
          :username => "tom",
          :password => "brady"
        }
      }
      post '/signup', params
      expect(last_response.body).to include("Username is already taken.")
    end
  end
end
