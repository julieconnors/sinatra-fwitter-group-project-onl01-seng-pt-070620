class UsersController < ApplicationController

    get "/signup" do
        if !logged_in?
            erb :"/users/signup"
        else
            redirect "/tweets"
        end
    end

    post "/signup" do
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        if @user.valid?
            @user.save
            session[:user_id] = @user.id

            redirect "/tweets"
        else
            redirect "/users/signup"
        end
    end

    get "/login" do
        if !logged_in?
            erb :"/users/login"
        else
            redirect "/tweets"
        end
    end

    get "/users/:slug" do
            @user = User.find_by_slug(params[:slug])
            @tweets = @user.tweets

            erb :"/users/show"
    end

    post "/login" do
        @user = User.find_by(username: params[:username])
        if @user.authenticate(params[:password])
            session[:user_id] = @user.id

            redirect "/tweets"
        else
            redirect "/login"
        end
    end

    get "/logout" do
        if logged_in?
            session.clear 

            redirect "/login"
        else
            redirect "/"
        end
    end
end
