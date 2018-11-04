class CommentsController < ApplicationController
  before_action :authenticate_user!
  #authenticate_user!の機能は、deviseの機能。railsオリジナルの機能ではない。

  def create
    #保存
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    # @comment.post_id = current_user.id
    @comment.user_id = current_user.id
    @comment.save

    redirect_to"/posts/#{;params[:post_id]}"
    #redirect_to"/posts"
  end
  
  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end