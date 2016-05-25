class Api::V1::SessionsController < Devise::SessionsController

  respond_to :json

  def login

    if (params[:username] || params[:email]) && params[:password]
      @user = devise_login
    end

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

  private

  def decrypt(data, key)
    cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
    cipher.decrypt
    cipher.key = cipher_key = Digest::SHA256.digest(key)
    random_iv = data[0..15] # extract iv from first 16 bytes
    data = data[16..data.size-1]
    cipher.iv = Digest::SHA256.digest(random_iv + cipher_key)[0..15]
    begin
      decrypted = cipher.update(data)
      decrypted << cipher.final
    rescue OpenSSL::CipherError, TypeError
      return nil
    end

    return decrypted
  end

  def set_session_headers
    session[:HTTP_AUTHORIZATION_USERNAME] = params[:username]
    session[:HTTP_AUTHORIZATION_TOKEN] = get_md5_digest(params[:username])
  end

  def token_based_login
    @user = User.where(username: params[:username]).first || User.create!(username: params[:username], email: "email@email#{ rand(3000)}.com", password: "password")


    #if get_md5_digest(params[:username]) == params[:token]
    #end
  end

  def devise_login
    resource = User.find_by_username(params[:username]) || User.find_by_email(params[:email])
    # sign_in(resource_name, resource)
    resource if resource.valid_password?(params[:password])
  rescue
    nil
  end
end
