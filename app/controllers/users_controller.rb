class UsersController < ApplicationController
  def index
    @users = User.all
    @tweet = Tweet.new
  end

  def show
    @user = User.find(params[:id])
     @tweets = @user.tweets
    # @tweet = Tweet.new
  end

  def edit
  end

  def update
  end

  def user_params
    params.require(:user).permit(:name, :profile_image_id, :introduction)
  end
end
