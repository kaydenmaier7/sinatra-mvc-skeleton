helpers do

  def current_user
    @current_user ||= User.find(session[:id]) if session[:id]
  end

  def logged_in?
    current_user
  end

  def login(user)
    session[:id] = @user.id
  end

  def logout
    session[:id] = nil
  end

  def login_errors(form_params)

    case
    when form_params['password'].empty?
      return "Please enter your password."
    when (form_params['email'].empty? && form_params['username'].empty?)
      return "Please enter either your email or username."
    else
      return "The credentials don't match anything on record."
    end

  end

end
