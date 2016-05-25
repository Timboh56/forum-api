class Api::V1::VotesController < ApplicationController
  def show
    vote = Vote.find(params[:id])
    render json: vote
  end

  def create
    vote = Vote.create!(vote_params)
    render json: vote
  end

  def destroy
    Vote.find(params[:id]).destroy!
    render json: { destroyed: true }
  end

  def vote_params
    params.require(:vote).permit(:votable_id, :votable_type, :user, :user_id)
  end
end
