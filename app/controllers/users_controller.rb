class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @articles_count = Article.where(user_id: @user.id).count
    @events_count = Event.where(user_id: @user.id).count
    @popular_posts_user = Event.where(user_id: @user.id).order(impressions_count: :desc).limit(2)
  end
  def feed
    @user = User.find(params[:id])
    @user_posts = Article.where(user_id: @user.id) + Event.where(user_id: @user.id)

    render partial: 'users/blocks/feed', locals: { user: current_user }
  end

  def bookmarks
    # Код для получения данных для закладок пользователя
    render partial: 'users/blocks/bookmarks', locals: { user: current_user }
  end

  def lenta
    post_list = []

    current_user.subscribed_users.each do |sub|
      post_list << Event.where(user_id: sub.id) + Article.where(user_id:sub.id)
    end
    @posts = post_list.flatten
  end

  def users
    @users = User.all
  end

  def news
    @items = Update.all
    respond_to do |format|
      format.html { render partial: 'items', locals: { items: @items } }
      format.js
    end
  end

  def articles
    @items = Article.all
    respond_to do |format|
      format.html { render partial: 'items', locals: { items: @items } }
      format.js
    end
  end
end
