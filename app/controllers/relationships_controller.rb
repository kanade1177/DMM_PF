class RelationshipsController < ApplicationController
  def create
    #元々のやつ
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    # binding.pry
    if follow.save
    #後から追加
      @user = User.find(params[:user_id])
      # current_user.id = following_id
      @user.create_notification_follow!(current_user)

    end
    #元々のやつ
    redirect_to request.referer
  end

  def destroy
    #元々のやつ
    Relationship.find_by(params[:user_id]).destroy
    redirect_to request.referer



  end
end
