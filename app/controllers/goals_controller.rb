class GoalsController < ApplicationController

  get '/goals' do
    redirect_if_not_logged_in
    erb :'goal/index'
  end

end
