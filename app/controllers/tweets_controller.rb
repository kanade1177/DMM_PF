class TweetsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit]

  def new
    @tweet = Tweet.new
  end

  def index
    @tweets = Tweet.page(params[:page]).reverse_order.order(created_at: :desc)
  end

  def show
    @tweet = Tweet.find(params[:id])
    # マップ用の記述
    gon.tweet = @tweet
    @user = @tweet.user
    @comment = Comment.new
    @comments = @tweet.comments.order(created_at: :desc)
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      #VisionAPI
      tags = Vision.get_image_data(@tweet.post_image)
      tags.each do |tag|
        @tweet.tags.create(name: tag)
      end
      redirect_to tweets_path
    else
      render :new
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to tweet_path(@tweet.id)
    else
      render :edit
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to action: :index
  end

  def category
    @tweets = Tweet.where(category_id: params[:id]).order("created_at DESC") # 追記
    @tweet = Tweet.find_by(category_id: params[:id]) # 追記
  end

  private

  def tweet_params
    params.require(:tweet).permit(:title, :body, :post_image, :category_id, :erea_id, :address, :latitude, :longitude)
  end

  def ensure_correct_user
    @tweet = Tweet.find(params[:id])
    unless @tweet.user == current_user
      redirect_to tweet_path
    end
  end
end
