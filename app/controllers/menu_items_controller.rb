class MenuItemsController < ApplicationController
  # get "/:restaurant_slug/menu_items" do
  #   @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
  #   @menu_items = @restaurant.menu_items
  #   if Helpers.logged_in?(session)
  #     erb :"menu_items/menu_items"
  #   else
  #     redirect to "/login"
  #   end
  # end

  # get "/menu_items/new" do
  #   if Helpers.logged_in?(session)
  #     erb :"menu_items/new"
  #   else
  #     redirect to "/login"
  #   end
  # end


  get "/:restaurant_slug/menu_items/:id" do
    @menu_item = MenuItem.find(params[:id])
    @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
    redirect to "/#{@menu_item.restaurant.slug}/menu_items/#{@menu_item.id}" if !@restaurant.menu_items.include?(@menu_item)
    erb :"menu_items/show_menu_item"
  end

  post "/:restaurant_slug/menu_items" do
    restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
    menu_item = MenuItem.new(name:params[:name], restaurant: restaurant)

    if menu_item.save
      redirect to "/#{restaurant.slug}/menu_items/#{menu_item.id}"
    else
      redirect to "/#{restaurant.slug}/menu_items?error=there was a problem creating the menu item"
    end
  end

  # get "/menu_items/:id/edit" do
  #   @menu_item = MenuItem.find(params[:id])
  #   if !Helpers.logged_in?(session)
  #     redirect to "/login"
  #   elsif !!@menu_items && Helpers.logged_in?(session) && @menu_items.user == Helpers.current_user(session)
  #     erb :"tweets/edit_tweet"
  #   elsif !!@tweet
  #     redirect to "/tweets/#{@tweet.id}"
  #   else
  #     redirect to "/tweets"
  #   end
  # end

end
