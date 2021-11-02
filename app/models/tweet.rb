class Tweet < ApplicationRecord
  attachment :post_image

  belongs_to :user
  has_many :favorites
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :tags, dependent: :destroy

  geocoded_by :address # マップ用
  after_validation :geocode, if: :address_changed? # マップ用

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :erea

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 1, maximum: 280 }
  validates :address, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # コメント機能通知
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      tweet_id: id,
      visited_id: user_id,
      action: "comment"
    )
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  # いいね通知
  def create_notification_favorite!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and tweet_id = ? and action = ?", current_user.id, user_id, id, "favorite"])
    if temp.blank?
      notification = current_user.active_notifications.new(
        tweet_id: id,
        visited_id: user_id,
        action: "favorite"
      )
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # サーチ

  def self.looks(search, word)
    if search == "perfect_match"
      @tweet = Tweet.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @tweet = Tweet.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @tweet = Tweet.where("title LIKE?", "%#{word}")
    elsif search == "partial_match"
      @tweet = Tweet.where("title LIKE?", "%#{word}%")
    else
      @tweet = Tweet.all
    end
  end
end
