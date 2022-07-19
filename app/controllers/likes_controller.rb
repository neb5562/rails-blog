class LikesController < ApplicationController
  before_action :authenticate_user!

  def save
    @like = Like.find_or_initialize_by(like_params)
    @like.persisted? ? res = @like.destroy : res = @like.save
    if res
      render json: @like, status: :created
    else
      render json: { errors: @like.errors }, status: :unprocessable_entity
    end
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :comment_id, :post_id)
  end
end
