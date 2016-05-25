class Api::V1::BookmarksController < ApplicationController
  def create
    @bookmark = Bookmark.create!(bookmark_params)

    render json: @bookmark, serializer: BookmarkSerializer
  end

  def destroy
    Bookmark.find(params[:id]).destroy!
    render nothing: true, status: 200, serializer: BookmarkSerializer
  end

  def show
    render json: Bookmark.find(params[:id])
  end

  def index
    @user = User.find(params[:user_id])
    render json: @user.bookmarks, include: [ :question ], each_serializer: BookmarkSerializer
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:bookmarkable_id, :bookmarkable_type, :user_id)
  end
end
