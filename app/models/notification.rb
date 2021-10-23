class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  # # nillを許可

  belongs_to :tweet, optional: true
  belongs_to :comment, optional: true
  belongs_to :visiter, class_name: "User", optional: true
  belongs_to :visited, class_name: "User", optional: true
end
