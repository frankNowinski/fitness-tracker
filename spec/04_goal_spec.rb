describe GoalsController do

  describe 'New Goal' do
    it 'loads the new goal page when a user initially signs up' do

      visit '/signup'

      fill_in(:username, :with => "tom")
      fill_in(:password, :with => "brady")

      click_button 'signup'
      expect(page.current_path).to eq('/goals/new')
    end

    it 'directs the user to the weekly goal page when a user logs in' do
      user = User.create(username: "tom", password: "brady")
      user.goals.create(title: "First Goal")

      visit '/'

      fill_in(:username, :with => "tom")
      fill_in(:password, :with => "brady")

      click_button 'login'
      expect(page.current_path).to eq('/goals/new')
    end

    # it 'creates a new goal' do
    #   params = {
    #     :title => "Goal",
    #     :entries => {
    #       :chest => 50,
    #       :legs => 30
    #     }
    #   }
    #
    #   post '/goals', params
    #   session = {}
    #   session[:user_id] = 1
    #   expect(last_response.status).to eq(302)
    #   follow_redirect!
    #   expect(last_response.status).to eq(302)
    # end
  end
end
