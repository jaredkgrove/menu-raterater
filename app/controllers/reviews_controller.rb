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

    get "/:restaurant_slug/reviews/new" do
      @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
      @menu_items = @restaurant.menu_items
      if Helpers.logged_in?(session)
        erb :"reviews/new"
      else
        redirect to "/login"
      end
    end

    get "/reviews/:id" do
      if Helpers.logged_in?(session)
        @review = Review.find(params[:id])
        @menu_item = @review.menu_item
        @user = @review.user
        @restaurant = @menu_item.restaurant
        erb :"reviews/show_review"
      else
        redirect to "/login"
      end
    end

    get "/reviews/:id/edit" do
      @review = Review.find(params[:id]) if !Review.where(id:params[:id]).empty?
      if !Helpers.logged_in?(session)
        redirect to "/login"
      elsif !!@review && Helpers.logged_in?(session) && @review.user == Helpers.current_user(session)
        erb :"tweets/edit_tweet"
      elsif !!@review
        redirect to "/reviews/#{@review.id}"
      else
        redirect to "/reviews"
      end
    end
# TODO: creates menu_item and Restaurant if they do not exist
    post "/reviews" do
      if !params[:rating].empty?
        review = Review.create(rating: params[:rating], comment: params[:comment], user: Helpers.current_user(session))
        redirect to "/reviews/#{review.id}"
      else
        redirect to "/reviews/new"
      end
    end
# TODO: creates menu_item and Restaurant if they do not exist
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
