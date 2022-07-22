class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.from_omniauth(request.env['omniauth.auth'])
      @user_obj = @user[:user]

      if @user[:new_user] == true
        force_password_change @user_obj
        return
      end

      if @user_obj.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect @user_obj, event: :authentication
      else
        session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
        redirect_to new_user_registration_url, alert: @user_obj.errors.full_messages.join("\n")
      end
  end

  def force_password_change(user_obj)
    flash[:notice] = "Please Set your password!"
    sign_in(:user, user_obj)
    token = user_obj.send(:set_reset_password_token)
    sign_out(user_obj)
    redirect_to(edit_password_path(:user, reset_password_token: token))
  end
end