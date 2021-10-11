class RelationshipsController < ApplicationController
  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    if follow.save
     follow.create_notification_follow!(current_user)
     redirect_to request.referer
    end
  end

  def destroy
    Relationship.find_by(params[:user_id]).destroy
    redirect_to request.referer
  end
end
