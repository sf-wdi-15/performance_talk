module SessionsHelper

  def current_user
    @current_user || User.find_by({id: session[:user_id]})
  end

  def logged_in?
    unless current_user
      redirect_to login_path
    end  
  end

  def login(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def logout
    @current_user = session[:user_id] = nil
  end

end
