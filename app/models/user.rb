# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[twitter facebook] # 追加
  # 　deviseでOmniAuthの機能を使うことができるようになる

  has_many :boards, dependent: :destroy
  has_many :todolists, dependent: :destroy
  attachment :profile_image

  validates :name, presence: true

  # find_or_create_for_oauthメソッド => コールバック用コントローラーで呼び出す
  # new_with_sessionメソッド => ユーザー登録用コントローラーから呼び出す

  # class << self
  def find_or_create_for_oauth(auth)
    find_or_create_by!(email: auth.info.email) do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      password = Devise.friendly_token[0..5]
      logger.debug password
      user.password = password
    end
  end

  def new_with_session(params, session)
    if user_attributes = session['devise.user_attributes']
      new(user_attributes) { |user| user.attributes = params }
    else
      super
    end
  end
  # end
end
