class Api::V1::UsersController < ApplicationController
  respond_to :json
  #before_action :authenticate_user!, only: [ :update, :destroy, :create ]
  def login

    if params[:username] && params[:token]
      @user = token_based_login
    end

    if @user
      set_session_headers
      render json: { username: @user.username, auth_token: get_md5_digest(params[:username]), logged_in: true }
    else
      render json: { logged_in: false }, status: 401
    end
  end

  def me
    @user = if params[:user_id]
      current_user(params[:user_id])
    else
      current_user
    end

    render json: @user, include: [ :answers, :questions, :user_badges => [:badge] ], serializer: UserSerializer
  end

  def show
    user = User.includes( :user_badges, :questions, answers: [ :comments, :tags, :question => [:user] ])
    @user = user.find(params[:id]) rescue user.where(username: params[:id]).first
    render json: @user, include: [ :badges, :user_badges, :questions, :answers => [:comments, :tags, :question => [:user] ] ], serializer: UserSerializer
  end

  def index
    show
  end

  def create
    @user = User.create!(user_params)
    render json: { user: @user }, status: 200
  rescue StandardError => e
    Rollbar.log('error', e)
  end

  private

  def set_session_headers
    session[:HTTP_AUTHORIZATION_USERNAME] = params[:username]
    session[:HTTP_AUTHORIZATION_TOKEN] = get_md5_digest(params[:username])
  end

  def token_based_login
    @user = User.where(username: params[:username]).first || User.create!(username: params[:username], email: "email@email#{ rand(3000)}.com", password: "password")
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def test_user
    User.where(email: "testuser@email.com").first || User.create!(test_user_params)
  end

  def test_user_params
    { password: "password", email: "testuser@email.com" }
  end
end
