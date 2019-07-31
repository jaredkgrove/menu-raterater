class ReviewsController < ApplicationController
    # get "/:restaurant_slug/:menu_item_slug/reviews" do
    #   @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
    #   @menu_item = MenuItem.find_by_slug(params[:menu_item_slug])
    #   if Helpers.logged_in?(session)
    #     erb :"reviews/reviews"
    #   else
    #     redirect to "/login"
    #   end
    # end

    get "/:restaurant_slug/menu_items/:menu_item_id/reviews/new" do
      if Helpers.logged_in?(session)
        @menu_item = MenuItem.find(params[:menu_item_id])
        @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
        redirect to "/#{@menu_item.restaurant.slug}/menu_items/#{@menu_item.id}" if !@restaurant.menu_items.include?(@menu_item)
        erb :"reviews/new"
      else
        redirect to "/login"
      end
    end

    get "/:restaurant_slug/menu_items/:menu_item_id/reviews/:id" do
      @review = Review.find(params[:id])
      @menu_item = MenuItem.find(params[:menu_item_id])
      @user = @review.user
      @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
      # binding.pry
      redirect to "/#{@review.menu_item.restaurant.slug}/menu_items/#{@review.menu_item.id}/reviews/#{@review.id}" if !(@review.menu_item == @menu_item && @restaurant.menu_items.include?(@menu_item))
      erb :"reviews/show_review"
    end

    get "/:restaurant_slug/menu_items/:menu_item_id/reviews/:id/edit" do
      @review = Review.find(params[:id]) if !Review.where(id:params[:id]).empty?
      if !Helpers.logged_in?(session)
        redirect to "/login"
      elsif !!@review && Helpers.logged_in?(session) && @review.user == Helpers.current_user(session)
        erb :"reviews/edit_review"
      elsif !!@review
        redirect to "/#{params[:restaurant_slug]}/menu_items/#{params[:menu_item_id]}/reviews/#{params[:id]}"
      else
        redirect to "/#{params[:restaurant_slug]}/menu_items/#{params[:menu_item_id]}"
      end
    end

    post "/:restaurant_slug/menu_items/:menu_item_id/reviews" do
      review = Review.new(rating: params[:rating], comment: params[:comment], user: Helpers.current_user(session), menu_item_id: params[:menu_item_id] )
      if review.save
        redirect to "/#{params[:restaurant_slug]}/menu_items/#{params[:menu_item_id]}/reviews/#{review.id}"
      else
        redirect to "/#{params[:restaurant_slug]}/menu_items/#{params[:menu_item_id]}?error=There was a problem creating the review"
      end
    end

    patch "/reviews/:id" do
      @review = Review.find(params[:id])
      # raise params.inspect
      if !params[:rating].empty?
        @review.update(params) #Check params hash to include rating, comment, menu_item, and ???restaurant???
        redirect to "/reviews/#{@review.id}"
      else
        redirect to "/reviews/#{@review.id}/edit"
      end
    end

    delete "/reviews/:id" do
      Review.find(params[:id]).destroy if Helpers.logged_in?(session) && Review.find(params[:id]).user == Helpers.current_user(session)
      redirect to "/reviews"
    end

end
