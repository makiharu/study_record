# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  def twitter
    callback
  end

  def facebook
    callback
  end
  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
  private

  # Facebook／Twitter連携では処理を共通化
  # callbackメソッドに共通化した処理を定義して呼び出す
  # 1行目 OAuth認証の情報から取得されるユーザーが登録済みであればfind結果を、
  # 未登録であれば新規作成したユーザーのインスタンスを返すメソッド
  # request.env['omniauth.auth']とすることで、OAuth認証後にユーザー情報が得られる

  def callback
    @user = User.find_or_create_for_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user
    else
      session['devise.user_attributes'] = @user.attributes
      redirect_to new_user_registration_url
    end
end
end
