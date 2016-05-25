class SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token, :only => :create
  respond_to :json

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    return render :json => {:success => true}
  end
end  