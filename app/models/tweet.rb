class Tweet < ApplicationRecord
  attachment :post_image

  belongs_to :user
end
