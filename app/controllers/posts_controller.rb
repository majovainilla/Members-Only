class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit]
  
  def new

  end

  def create
  end

  def index
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end
end
