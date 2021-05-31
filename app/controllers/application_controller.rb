require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get "/" do
    erb :"/home"
  end

  helpers do 
    def logged_in? #checks if a user is logged in
      !!session[:user_id]
    end

    def current_user #finds User object matching session user_id
      User.find(session[:user_id])
    end

    def logged_out_redirection #checks if a user is not logged in and redirects to login page
      if !logged_in?
        redirect "/login"
      end
    end
  end
end
