class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def vkontakte
    provider_login 'Vkontakte'
  end

  def twitter
    provider_login 'Twitter'
  end

  def facebook
    provider_login 'Facebook'
  end

  def yandex
    provider_login 'Yandex'
  end

  def google
    provider_login 'Google'
  end

  private

  def provider_login kind
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
    else
      flash[:error] = 'Error of authorization.'
      redirect_to root_path
    end
  end
end