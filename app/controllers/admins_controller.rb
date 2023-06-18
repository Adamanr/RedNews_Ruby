class AdminsController < ApplicationController
  def index
    @user_count = User.all.count
    @post_count = Event.all.count + Article.all.count
    @users = User.all
    @editions = Edition.where(verified: false)
    @comments = ArticlesComment.all + EventComment.all
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

  def add_admin
    user_id = params[:id]
    @u = User.find(user_id)
    @u.verified = true
    if @u.save
      render json: @u
    else
      render json: @u, status: 500
    end
  end

  def un_admin
    user_id = params[:id]
    @u = User.find(user_id)
    @u.verified = false
    if @u.save
      render json: @u
    else
      render json: @u, status: 500
    end
  end
end
