class Tweet < ApplicationRecord
  attachment :post_image

  belongs_to :user
  has_many :favorites
  has_many :comments, dependent: :destroy


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :erea

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
