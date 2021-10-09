class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   attachment :profile_image
   has_many :tweets
   has_many :favorites

  # 自分がフォローしているユーザーとの関係
   has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
   has_many :followings, through: :active_relationships, source: :follower

  # 自分がフォローされているユーザーとの関係
   has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
   has_many :followers, through: :passive_relationships, source: :following

   def followed_by?(user)
     passive_relationships.find_by(following_id: user.id).present?
   end
end
