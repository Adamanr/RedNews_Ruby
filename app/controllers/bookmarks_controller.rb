class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @bookmarkable = params[:bookmarkable_type].constantize.find(params[:bookmarkable_id])
    current_user.bookmarks.create(bookmarkable: @bookmarkable)
    redirect_to @bookmarkable
  end

  def destroy
    @bookmarkable = params[:bookmarkable_type].constantize.find(params[:bookmarkable_id])
    current_user.bookmarks.where(bookmarkable: @bookmarkable).destroy_all
    redirect_to @bookmarkable
  end
end
