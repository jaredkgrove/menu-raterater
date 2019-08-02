require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    erb :index
  end

  helpers do
    def redirect_if_not_owner(review)
      if review.user != Helpers.current_user(session)
        redirect "/#{review.menu_item.restaurant.slug}/menu_items/#{review.menu_item.id}"
      end
    end
  end

end
