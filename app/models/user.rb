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
  has_many :done_todolists, -> { where(done: true) }, class_name: 'Todolist'

  has_many :labels, through: :done_todolists
  #has_many :done_labels, through: :done_todolists, class_name: 'Label', source: :label_id

  # follow-follower
  has_many :active_relationships, class_name: 'Relationship', foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  attachment :profile_image

  validates :name, presence: true

#  def self.hoge
#    where(done: true)
#  end

  # user紐づくtodolists取得する
  # 各todolist紐づく複数ラベル取得
  def get_labels
    #labels
    #=> [ label<id: 1, name: 'html'>, label<id: 2, name: 'css', label<id: 1, name: 'html'> ]
    #done_todolists = todolists.only_done
    #labels = done_todolists.map { |list| list.labels.pluck(:name) }.flatten
    #=> ['html', 'css', 'html', 'html']
    #labels.group_by(&:itself).map{ |key, value| [key, value.count] }.to_h
    labels.group_by(&:name).map{ |key, value| [key, value.count] }.to_h
    #labels.group_by(&:name).map{ |key, value| [key, value.count] }.to_h
  end

  def done_list_sum #達成したtodoリストの数
    #get_labels.flatten.length
    done_todolist = todolists.only_done
    done_todolist.pluck(:done).count
  end


  def today_list_sum #その日達成したtodoリストの数
    today_lists = todolists.only_done
    today_lists.where(created_at: Time.zone.now.all_day).count
  end


  def followed_by?(user)
    # フォローされているpassiveユーザーの中から、引数に渡されたuserがいるかどうかjudge
    passive_relationships.find_by(following_id: user.id).present?
  end

  def self.find_for_oauth(auth)
    # user = User.where(uid: auth.uid, provider: auth.provider).first

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
