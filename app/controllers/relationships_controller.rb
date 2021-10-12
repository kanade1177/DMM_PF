class RelationshipsController < ApplicationController
  def create
    #元々のやつ
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    #後から追加
    # @user = User.find(params[:following_id])
    # @user.create_notification_follow!(current_user)
    #元々のやつ
    redirect_to request.referer



  end

  def destroy
    #元々のやつ
    Relationship.find_by(params[:user_id]).destroy
    redirect_to request.referer



  end
end
