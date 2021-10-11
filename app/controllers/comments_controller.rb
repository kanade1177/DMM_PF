class CommentsController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    # @comment = @tweet.comments.build(comment_params)
    # @comment.user_id = current_user.id
    @comment = current_user.comments.new(comment_params)
    @comment.tweet_id = @tweet.id
    @comment.save
    # if Tweet.create_notification_comment(current_user, @comment.id)
    #   @comment = current_user.comments.new(comment_params)
    # end
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.find(params[:id])
    @comment.destroy

  end

  private

  def comment_params
    params.require(:comment).permit(:content, :tweet_id, :user_id)
  end

end
