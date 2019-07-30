class Helpers
  def redirect_if_not_logged_in(session)
    if !logged_in?(session)
      redirect "/login?error=You have to be logged in to do that"
    end
  end

  def self.current_user(session)
    User.find_by(:id => session[:user_id])
  end

  def self.logged_in?(session)
    !!User.find_by(:id => session[:user_id])
  end
end
