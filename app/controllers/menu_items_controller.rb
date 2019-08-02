class MenuItemsController < ApplicationController

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

end
