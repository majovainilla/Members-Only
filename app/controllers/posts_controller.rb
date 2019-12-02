class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post succesfully created!"
    redirect_to posts_path
    else
      flash[:danger] = "Sorry, I can't create the post"
      render 'new'
    end
    
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

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
