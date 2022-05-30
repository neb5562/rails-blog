class CommentsController < ApplicationController
  before_action :authenticate_user!

  def save
    # @comment = current_user.comments.build(comment_params)
    @comment = Comment.new(body: params['body'], user_id: current_user.id, blog_id: params[:id])
    respond_to do |format|
      if @comment.save
        format.html { redirect_to show_blog_url(params[:id]), notice: "Comment was successfully created." }
        # format.json { render :show, status: :created, location: @blog }
      else
        format.html { redirect_to show_blog_url(params[:id]), alert: "Comment was not created." }
        # format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  private 

  def comment_params
    params.permit(:body)
  end

end
