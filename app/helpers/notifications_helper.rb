module NotificationsHelper
  # いいねだけの時
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    @visiter_comment = notification.comment_id
    case notification.action
    when "follow" then
      tag.a(notification.visiter.name, href: user_path(@visiter)) + "があなたをフォローしました"
    when "favorite" then
      tag.a(notification.visiter.name, href: user_path(@visiter)) + "が" + tag.a("あなたの投稿", href: tweet_path(notification.tweet_id)) + "にいいねしました"
    when "comment" then
      @comment = Comment.find_by(id: @visiter_comment)&.content
      # @comment = Comment.find_by(id: @visiter_comment)
      # @comment_content = @comment.content
      # @tweet_title = @comment.tweet.title
      tag.a(@visiter.name, href: user_path(@visiter)) + "が" + tag.a("あなたの投稿", href: tweet_path(notification.tweet_id)) + "にコメントしました"
    end
  end
end
