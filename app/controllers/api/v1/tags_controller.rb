class Api::V1::TagsController < ApplicationController
  def index
    if params[:id] || params[:text]
      @tag = Tag.includes(
        :taggings,
        :taggings => [:taggable]
      ).find_by_text(params[:id] || params[:text])
    else
      @tags = Tag.includes(
        :taggings,
        :taggings => [:taggable]
      ).all.limit(20).order(taggings_count: :desc)
    end

    if @tag
      @taggings = Tagging.includes(:taggable).where(tag_id: @tag.id)

      render json: @tag, include: [ :taggings => [:taggable => :user ]], serializer: TagSerializer
    else
      render json: @tags, include: [ :taggings => [:taggable => :user ]], each_serializer: TagSerializer
    end
  end

  def show
    index
  end
end
