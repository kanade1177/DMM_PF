class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(20)
    @tweet = Tweet.new
  end

  def show
    @user = User.find(params[:id])
     @tweets = @user.tweets.order(created_at: :desc)
    # @tweet = Tweet.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
     if @user.update(user_params)
     redirect_to user_path(@user.id)
     else
      render :edit
     end
  end



  private

    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end
end
