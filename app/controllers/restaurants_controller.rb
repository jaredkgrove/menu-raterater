class RestaurantsController < ApplicationController
  get "/restaurants" do
    if Helpers.logged_in?(session)
      erb :"restaurants/restaurants"
    else
      redirect to "/login"
    end
  end

  # get "/restaurants/new" do
  #   if Helpers.logged_in?(session)
  #     erb :"restaurants/new"
  #   else
  #     redirect to "/login"
  #   end
  # end

  get "/restaurants/:id" do
    if Helpers.logged_in?(session)
      @restaurant = Restaurant.find(params[:id])
      erb :"restaurants/show_restaurant"
    else
      redirect to "/login"
    end
  end

  # get "/restaurants/:id/edit" do
  #   @restaurant = Restaurant.find_by_slug(params[:slug])
  #   if !Helpers.logged_in?(session)
  #     redirect to "/login"
  #   elsif !!@restaurant && Helpers.logged_in?(session) && @restaurant.user == Helpers.current_user(session)
  #     erb :"tweets/edit_tweet"
  #   elsif !!@tweet
  #     redirect to "/tweets/#{@tweet.id}"
  #   else
  #     redirect to "/tweets"
  #   end
  # end

end
