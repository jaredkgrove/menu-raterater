class ReviewsController < ApplicationController

    get "/reviews" do
      if Helpers.logged_in?(session)
        erb :"reviews/reviews"
      else
        redirect to "/login"
      end
    end

    get "/reviews/new" do
      if Helpers.logged_in?(session)
        erb :"reviews/new"
      else
        redirect to "/login"
      end
    end

    get "/reviews/:id" do
      if Helpers.logged_in?(session)
        @review = Review.find(params[:id])
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
        @review.update(params)
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to "/tweets/#{@tweet.id}/edit"
      end
    end

    delete  "/tweets/:id" do
      Tweet.find(params[:id]).destroy if Helpers.logged_in?(session) && Tweet.find(params[:id]).user == Helpers.current_user(session)
      redirect to "/tweets"
    end

end
