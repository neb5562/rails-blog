class CommentsController < ApplicationController
  before_action :authenticate_user!

  def save
    # @comment = current_user.comments.build(comment_params)
    @post = Post.find_by_hashid(params[:id])
    @comment = Comment.new(body: params['body'], user_id: current_user.id, post_id: @post.id)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to show_post_url(params[:id]), notice: "Comment was successfully created." }
        # format.json { render :show, status: :created, location: @blog }
      else
        format.html { redirect_to show_post_url(params[:id]), alert: "Comment was not created." }
        # format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  private 

  def comment_params
    params.permit(:body)
  end

end
