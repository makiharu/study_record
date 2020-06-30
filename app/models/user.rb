# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[twitter facebook] # 追加
  # 　deviseでOmniAuthの機能を使うことができるようになる

  has_many :boards, dependent: :destroy
  has_many :board_comments, dependent: :destroy
  has_many :comment_likes, dependent: :destroy

  has_many :todolists, dependent: :destroy
  has_many :board_likes, dependent: :destroy

  # follow-follower
  has_many :active_relationships, class_name: 'Relationship', foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  attachment :profile_image

  validates :name, presence: true

  def followed_by?(user)
    # フォローされているpassiveユーザーの中から、引数に渡されたuserがいるかどうかjudge
    passive_relationships.find_by(following_id: user.id).present?
  end

  def self.find_for_oauth(auth)
    #user = User.where(uid: auth.uid, provider: auth.provider).first

    # user ||= User.create(
    #   uid: auth.uid,
    #   provider: auth.provider,
    #   email: auth.info.email,
    #   password: Devise.friendly_token[0, 20]
    # )
    User.where(uid: auth.uid, provider: auth.provider).first

    User.create(
      uid: auth.uid,
      provider: auth.provider,
      email: auth.info.email,
      password: Devise.friendly_token[0, 20]
    )
  end
end
