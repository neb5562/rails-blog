class LikesController < ApplicationController
  before_action :authenticate_user!

  def save
    @like = Like.find_or_initialize_by(like_params)
    @like.persisted? ? res = @like.destroy : res = @like.save
    respond_to do |format|
      if res
        format.html {  1 }
        format.json {  1 }
      else
        format.html {  0 }
        format.json {  render root_path }
      end
    end
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :comment_id)
  end
end
