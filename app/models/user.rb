class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   attachment :profile_image
   has_many :tweets
   has_many :favorites
   has_many :comments

  # 自分がフォローしているユーザーとの関係
   has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
   has_many :followings, through: :active_relationships, source: :follower

  # 自分がフォローされているユーザーとの関係
   has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
   has_many :followers, through: :passive_relationships, source: :following

   # 自分が作った通知関連
   has_many :active_notifications, class_name: "Notification", foreign_key: :visiter_id, dependent: :destroy
   # 自分宛の通知関連
   has_many :passive_notifications, class_name: "Notification", foreign_key: :visited_id, dependent: :destroy


   def followed_by?(user)
     passive_relationships.find_by(following_id: user.id).present?
   end

   def create_notification_follow!(current_user)
    if follow_exit.blank?
     notification = current_user.active_notifications.new(
      visited_id: id,
      action: "follow",
      checked: fales
     )
     notification.save if notification.valid?
    end
   end
end
