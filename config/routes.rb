Rails.application.routes.draw do

  root 'home#top'
  get 'home/about', to: 'home#about'
  resources :contacts, only: %i[new create]

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks' # SNS認証時のコールバック処理
  }

  devise_scope :user do #kantan login
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  devise_scope :admin do #kantan login
    post 'admins/guest_sign_in', to: 'admins/sessions#new_guest'
  end

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords'
  }

  scope module: :public do
    resources :boards, only: %i[new create index edit show update] do
      resource :board_likes, only: %i[create destroy]
      resources :board_comments, only: %i[create destroy edit update destroy] do
        resource :comment_likes, only: %i[create destroy]
      end
    end
    resources :users, only: %i[index show edit update] do
      resources :relationships, only: %i[create destroy]
      get :follows, on: :member
      get :followers, on: :member
      get 'users/password', to: 'users#edit_password' #パスワード変更用
      put 'users/password', to: 'users#update_password'
      get :user_boards, only: [:index] #add past_user_boards/view
    end
      resources :board_likes, only: [:index]
      resources :todolists, except: [:show]
      patch 'todolists/:id/clear', to: 'todolists#clear', as:'todolists_clear' #Ajax
      put '/users/:id/hide' => 'users#hide', as:'users_hide'
  end

  namespace :manage do
    resources :users, except: [:destroy]
    resources :boards, only: %i[index show update edit destroy] do
      resource :board_comment, only: [:destroy]
    end
  end

  scope module: :manage do
    get 'home/top'
    resources :labels, except: [:show]
    resources :tags, except: [:show]
  end

end
