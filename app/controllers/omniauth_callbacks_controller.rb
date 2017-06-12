class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def social_signup
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.connect_to_social_medium(request.env["omniauth.auth"],current_user)

      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
  end

  alias_method :google_oauth2, :social_signup
  alias_method :google_oauth2, :social_signup
  alias_method :github, :social_signup
  alias_method :linkedin, :social_signup
  alias_method :twitter, :social_signup
  alias_method :facebook, :social_signup
end