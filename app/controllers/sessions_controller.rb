class SessionsController < ApplicationController


  def new
  end

  def create
    @user = User.find(email: params[:email])
    log_in @user
  end
end
