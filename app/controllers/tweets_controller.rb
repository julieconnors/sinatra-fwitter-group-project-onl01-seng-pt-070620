class TweetsController < ApplicationController

    get "/tweets" do
        if logged_in?
            @tweets = Tweet.all

            erb :"/tweets/index"
        else
            redirect "/login"
        end
    end

    get "/tweets/new" do
        if logged_in?
            erb :"/tweets/new"
        else
            redirect "/login"
        end
    end

    get "/tweets/:id" do
        if logged_in?
        @tweet = Tweet.find_by(id: params[:id])

        erb :"/tweets/show"
        else
            redirect "/login"
        end
    end

    post "/tweets" do
        if logged_in?
            @tweet = Tweet.new(content: params[:content], user_id: current_user.id)
            if @tweet.valid?
                @tweet.save 

                redirect "/tweets"
            else
                redirect "/tweets/new"
            end
        end
    end

    get "/tweets/:id/edit" do
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            if @tweet && @tweet.user == current_user

                erb :"/tweets/edit"
            else
                redirect "/tweets"
            end
        else
            redirect "/login"
        end
    end

    patch "/tweets/:id" do
        if logged_in?
            if params[:content] == ""
                redirect to "/tweets/#{params[:id]}/edit"
              else
                @tweet = Tweet.find_by_id(params[:id])
                if @tweet && @tweet.user == current_user
                  if @tweet.update(content: params[:content])
                    redirect to "/tweets/#{@tweet.id}"
                  else
                    redirect to "/tweets/#{@tweet.id}/edit"
                  end
                else
                  redirect to '/tweets'
                end
              end
        else
            redirect "/login"
        end
    end

    delete "/tweets/:id" do
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            if @tweet && @tweet.user == current_user
                @tweet.destroy

                redirect "/tweets"
            else
                redirect "/tweets"
            end
        else
            redirect "/login"
        end
    end

end
