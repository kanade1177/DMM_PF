class Relationship < ApplicationRecord
  #元々のやつ
  belongs_to :following, class_name: "User", optional: true
  belongs_to :follower, class_name: "User",optional: true


end
