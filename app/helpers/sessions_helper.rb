module SessionsHelper

  def sign_in(p_user)
    cookies.permanent[:remember_token] = p_user.remember_token
    self.current_user = p_user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(p_user)
    @current_user = p_user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

end
