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
  #コメント機能通知
  def create_notification_by(current_user)
      notification = current_user.active_notifications.new(
          tweet_id: id,
          visited_id: user_id,
          action: "tweet"
        )
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
      
  end

  
end
