describe GoalsController do

  describe 'New Goal' do
    it 'loads the goal page' do
      # user = User.new(username: "steven", password: "avery")
      # visit '/login'
      #
      # fill_in(:username, :with => "steven")
      # fill_in(:password, :with => "avery")
      # click_button 'Login'

      visit '/goals'
      expect(last_response.status).to eq(200)
    end

    it 'loads the new goal page' do
      get '/goals/new'
      expect(last_response.status).to eq(200)
    end

    it 'must have fields filled in.' do
      user = User.new(username: "steven", password: "avery")
      visit '/login'

      fill_in(:username, :with => "steven")
      fill_in(:password, :with => "avery")
      click_button 'Login'
      get '/goals'
      expect(page.status).to eq(200)
    end
  end
end
