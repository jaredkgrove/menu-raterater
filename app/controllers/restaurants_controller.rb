class RestaurantsController < ApplicationController
  get "/restaurants" do
    if Helpers.logged_in?(session)
      erb :"restaurants/restaurants"
    else
      redirect to "/login"
    end
  end

  get "/restaurants/:slug" do
    if Helpers.logged_in?(session)
      @restaurant = Restaurant.find(params[:slug])
      erb :"restaurants/show_restaurant"
    else
      redirect to "/login"
    end
  end

  post "/restaurants" do
    restaurant = Restaurant.New(name: params[:name])
    if restaurant.save
      redirect to "/#{restaurant.slug}"
    else
      redirect to "/restaurants?error=enter a unique name for a restaurant"
    end
  end

end
