# frozen_string_literal: true

module SessionsHelper
  def log_in(user)
    user.remember
    cookies.permanent[:remember_token] = user.remember_me
  end

  def current_user
    @current_user ||= User.find_by(remember_me: cookies[:remember_token])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    cookies.permanent[:remember_token] = nil
    @current_user = nil
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
