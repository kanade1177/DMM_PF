class FavoritesController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    favorite = current_user.favorites.new(tweet_id: @tweet.id)
    favorite.save
    #追加
    # tweet = tweet.find(params[:tweet_id])
    # tweet.create_notification_favorite!(current_user)


  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    favorite = current_user.favorites.find_by(tweet_id: @tweet.id)
    favorite.destroy
    # redirect_to tweets_path
  end
end
