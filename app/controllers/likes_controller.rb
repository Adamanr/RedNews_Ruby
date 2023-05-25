class LikesController < ApplicationController
  def create
    @likeable = params[:likeable_type].constantize.find(params[:likeable_id])
    current_user.likes.create(likeable: @likeable)
    redirect_to @likeable
  end

  def destroy
    @likeable = params[:likeable_type].constantize.find(params[:likeable_id])
    current_user.likes.where(likeable: @likeable).destroy_all
    redirect_to @likeable
  end
end
