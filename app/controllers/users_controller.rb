class UsersController < ApplicationController
  def index
    @users = User.all
    @post = Post.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @post = Post.new
  end

  def edit
  end

  def update
  end
  
  def user_params
    params.require(:user).permit(:name, :profile_image_id, :introduction)
  end  
end
