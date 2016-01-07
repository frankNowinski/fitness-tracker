class EntriesController < ApplicationController

  # SHOW ENTRY
  get '/entry/:id' do
    redirect_if_not_logged_in
    @entry = Entry.find(params[:id])

    erb :'entry/show_entry'
  end

  # EDIT ENTRY
  get '/entry/:id/edit' do
    redirect_if_not_logged_in
    @entry = Entry.find(params[:id])

    erb :'entry/edit_entry'
  end

  post '/entry/:id/edit' do
    entry = Entry.find(params[:id])
    entry.update(params[:entries])
    Goal.find(entry.goal.id).update(title: params[:title])

    redirect "/entry/#{entry.id}"
  end

  # UPDATE ENTRY
  get '/entry/:id/update' do
    redirect_if_not_logged_in
    @entry = Entry.find(params[:id])

    erb :'entry/update_entry'
  end

  post '/entry/:id/update' do
    entry = Entry.find(params[:id])
    entry.update_entry(params)

    redirect "/weekly_goal"
  end

end
