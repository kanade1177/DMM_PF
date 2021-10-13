class FavoritesController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    favorite = current_user.favorites.new(tweet_id: @tweet.id)
    if favorite.save
    #追加
      @tweet = favorite.tweet
      @tweet.create_notification_favorite!(current_user)
    end

  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    favorite = current_user.favorites.find_by(tweet_id: @tweet.id)
    favorite.destroy
    # redirect_to tweets_path
  end
end
