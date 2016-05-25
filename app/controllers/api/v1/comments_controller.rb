class Api::V1::CommentsController < ApplicationController
  before_filter :verify_logged_in_status

  def create
    commentable_id = params["comment"]["commentable_id"]
    commentable = params["comment"]["commentable_type"].camelize.constantize.find(commentable_id)

    @comment = Comment.new(comment_params)
    @comment.commentable = commentable
    @comment.save!
    render json: @comment
  end

  def index
    page = params[:page] || 0
    klass = params['commentableType'].camelize.constantize
    commentable = klass.find(params['commentableId'])
    render json: commentable.comments.page(page), each_serializer: CommentSerializer
  end

  def show
    render json: Comment.find(params[:id]), serializer: CommentSerializer
  end

  def destroy
  end

  private

  def camelize(str)
    str.gsub('_')
  end

  def comment_params
    params.require(:comment).permit(:text, :anonymous, :commentable_id, :commentable_type, :user_id)
  end
end
