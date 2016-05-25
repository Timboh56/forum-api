class ApplicationController < ActionController::Base
  before_filter :restrict_access
  helper_method :current_user
  serialization_scope :view_context

  def current_user(user_id = nil)
    begin
      unless @current_user
        user_id = request.env['HTTP_AUTHORIZATION_USERID']
        username = request.env['HTTP_AUTHORIZATION_USERNAME']
        @current_user = User.includes(:answers, :questions => [:answers], :user_badges => [:badge])

        if user_id
          @current_user = @current_user.find(user_id)
        end

        if username
          @current_user = @current_user.find_by(username: username)
        end
      end

      @current_user
    rescue StandardError => e
      p e.message
      #Rollbar.log('error', e)
    end
  end

  def verify_logged_in_status
    request_username = request.headers['HTTP_AUTHORIZATION_USERNAME']
    request_token = request.headers['HTTP_AUTHORIZATION_TOKEN']
    if request_username && request_token
      digest = get_md5_digest(request_username)
      digest == request_token
    else
      render json: { logged_in: false }, status: 420
    end
  end

  def get_md5_digest(str)
    md5 = Digest::MD5.new
    md5.update(str)
    md5.hexdigest
  end

  def restrict_access
    begin
      unless restrict_access_by_header
        render json: {message: 'Invalid API Token'}, status: 401
        return
      end

      @current_user = @api_key.user if @api_key
    rescue StandardError => e
      Rollbar.error(e)
    end
  end

  def restrict_access_by_header
    @api_key = authenticate_and_return_api_key
  end

  def authenticate_and_return_api_key
    if request.headers['HTTP_AUTHORIZATION'] || params[:api_key]
      api_key = ApiKey.find_by_token(request.headers['HTTP_AUTHORIZATION'] || params[:api_key])
      api_key
    else
      nil
    end
  rescue
    nil
  end
end
