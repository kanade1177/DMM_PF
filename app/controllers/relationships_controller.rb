class RelationshipsController < ApplicationController
  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    if follow.save
    #通知機能
      @user = User.find(params[:user_id])
      @user.create_notification_follow!(current_user)

    end

    redirect_to request.referer
  end

  def destroy
    Relationship.find_by(params[:user_id]).destroy
    redirect_to request.referer
  end

  def followings
     user = User.find(params[:user_id])
     @users = user.followings.page(params[:page]).per(20)
  end

  def followers
     user = User.find(params[:user_id])
     @users = user.followers.page(params[:page]).per(20)
  end

end
