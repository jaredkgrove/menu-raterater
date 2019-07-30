class UsersController < ApplicationController

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end

  get "/signup" do
    if Helpers.logged_in?(session)
      redirect to "/restaurants"
    else
      erb :"users/create_user"
    end
  end

  get "/login" do
    if Helpers.logged_in?(session)
      redirect to "/restaurants"
    else
      erb :"users/login"
    end
  end

  get "/logout" do
    if Helpers.logged_in?(session)
      erb :"/users/logout"
    else
      redirect to "/login"
    end
  end

  post "/logout" do
    session.clear
    redirect to "/login"
  end

  post "/signup" do
    user = User.new(:name => params[:name], :password => params[:password])
    if user.save
      session[:user_id] = user.id
      redirect to "/restaurants"
    else
      redirect to "/signup"
    end
  end

  post "/login" do
    user = User.find_by(:name => params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/restaurants"
    else
      redirect to "/login"
    end
  end
end
