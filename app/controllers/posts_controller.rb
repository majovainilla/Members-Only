class PostsController < ApplicationController
 
  before_action :logged_in_user, only: [:new, :edit]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post succesfully created!"
    redirect_to posts_path
    else
      flash.now[:warning] = message
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
