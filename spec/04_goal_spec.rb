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
  end
end
