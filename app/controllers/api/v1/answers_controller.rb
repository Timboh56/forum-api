class Api::V1::AnswersController < ApplicationController
  def index
    render json: Answer.all.limit(100)
  end

  def show
    render json: Answer.find(params[:id]), serializer: AnswerSerializer
  end

  def create
    answer = Answer.create!(answer_params)
    render json: answer, serializer: AnswerSerializer
  end

  def answer_params
    params.require(:answer).permit(:text, :user, :user_id, :title, :question, :question_id )
  end
end
module Api::V1
end
