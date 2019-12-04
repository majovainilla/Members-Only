# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :logged_in_user, only: %i[new edit]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post succesfully created!'
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  private

  def logged_in_user
    return (flash[:danger] = 'Please log in') && (redirect_to login_url) unless logged_in?
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
