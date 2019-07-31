class RestaurantsController < ApplicationController
  get "/restaurants" do
    erb :"restaurants/restaurants"
  end

  get "/:slug" do
    @restaurant = Restaurant.find_by_slug(params[:slug])
    erb :"restaurants/show_restaurant"
  end

  post "/restaurants" do
    restaurant = Restaurant.new(name: params[:name])
    if restaurant.save
      redirect to "/#{restaurant.slug}"
    else
      redirect to "/restaurants?error=enter a unique name for a restaurant"
    end
  end

end
