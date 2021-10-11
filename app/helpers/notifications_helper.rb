module NotificationsHelper
  def notification_form(notification)
    visiter = notification.visiter


    case notification.action
     when "follow" then
       tag.a(notification.visiter.name, href: user_path(visiter)) + "があなたをフォローしました"
     when "favorite" then
       tag.a(notification.visiter.name, href: user_path(visiter)) + "が" + tag.a("あなたの投稿", href: tweet_path(notification.tweet_id)) + "にいいねしました"
    when "comment" then
      # comment = Comment.find_by(id visiter_comment)&.content
      tag.a(visiter.name, href: user_path(visiter)) + "が" + tag.a("#{tweet_title}", href: tweet_path(notification.tweet_id)) + "にコメントしました"
    end
  end
end
