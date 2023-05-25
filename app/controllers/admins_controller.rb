class AdminsController < ApplicationController
  def index
    @user_count = User.all.count
    @post_count = Event.all.count + Article.all.count
    @users = User.all
    @editions = Edition.where(verified: false)
  end

  def user_post_count(user)
    post_count = Event.where(user_id: user).count + Article.where(user_id: user).count
    return post_count
  end

  def submit
    edition_id = params[:id]
    @edition = Edition.find(edition_id)
    @edition.verified = true
    if @edition.save
      render json: @edition
    else
      render json: @edition, status: 500
    end
  end

  def delete
    edition_id = params[:id]
    @edition = Edition.find(edition_id)
    @edition.delete
    if @edition.save
      render json: @edition
    else
      render json: @edition, status: 500
    end
  end
end
