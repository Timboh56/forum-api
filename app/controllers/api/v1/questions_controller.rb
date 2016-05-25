class Api::V1::QuestionsController < ApplicationController
  respond_to :json
  #before_action :authenticate_user!, only: [ :update, :destroy ]
  before_action :set_param_defaults
  before_filter :verify_logged_in_status

  def index

    if params[:id]
      show
    else
      @questions = Question
        .includes(:user, :tags, :answers => [ :votes, :comments ])

      if params[:user_id]
        @questions = current_user.questions
      end

      if params[:keywords] && params[:keywords].present?
        @questions = @questions.search(params[:keywords]).records
      else
        @questions = @questions.all
      end

      @questions = @questions.page(params[:page]).per(params[:limit])

      if params[:mostActive] && params[:mostActive] == true
        @questions = @questions.order(activity_count: :desc)
      end

      total_pages = Question.count / (params[:perPage] || params[:limit])
      render json: @questions, except: [:answers], meta: { total_pages: total_pages }, include: [ :tags, :user], each_serializer: QuestionSerializer
    end
  end

  def show
    @question = Question.includes(
      :votes,
      :bookmarks,
      :tags,
      :user,
      answers: [ :user => [:user_badges] ]
    )

    @question = @question.find(params[:id]) rescue @question.find_by_title(params[:id])

    @question.increment!(:view_count)
    render json: @question, include: [
      :tags,
      :votes,
      :bookmarks,
      :user,
      answers: [
        :user => [
          :user_badges
        ]
      ]
    ], serializer: QuestionSerializer
  end

  def create
    @question = Question.create!(question_params)
    @question.setTags!(params['question']['tag_words'])
    render json: @question, serializer: QuestionSerializer
    # render json: @question # if using JSONAPIAdapter
  end

  def destroy

  end

  def update

  end

  private

  def set_param_defaults
    params[:limit] ||= 10
    params[:page] ||= 1
    params[:perPage] ||= 5

  end

  def question_params
    params.require(:question).permit(:text, :created_at, :comments_count, :title, :user_id)
  end
end
