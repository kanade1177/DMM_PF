class Tweet < ApplicationRecord
  attachment :post_image

  belongs_to :user
  has_many :favorites
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy



  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :erea

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def create_notification_favorite(current_user)
    # 既にいいね済みか検索
    temp = Notification.where(["visiter_id = ? and visited_id = ? and tweet_id = ? and action = ?", current_user.id, user_id, id, "favorite"])
    # いいねしてなければ通知
    if temp.blank?
      notification = current_user.acitive_notifications.new(
        tweet_id: id,
        visited_id: user_id,
        action: "favorite",
        cheked: false
        )
        notification.save if notification.valid?
    end

  end
  
  def create_notification_comment(current_user, comment_id)
    # 同じ投稿にコメントしたユーザーに通知
    temp_ids = Comment.select(:user_id).where(tweet_id: id).where.not(user_id: current_user.id).distinct
    # 通知作成(コメントしているユーザー)
    temp_ids.each do |temp_id|
     save_notification_comment(current_user, comment_id, temp_id["user_id"])
    end
    # 投稿者へ通知作成
    save_notification_comment(current_user, comment_id, user_id) if temp_ids.blank?
  end  
  
  def save_notification_comment(current_user, comment_id, visited_id)
    # 複数回コメントした時、通知も複数回分にする
    notification = current_user.active_notifications.new(
      tweet_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: "comment",
      checked: false
    )
    notification.save if notification.valid?  
  end
end
