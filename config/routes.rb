Rails.application.routes.draw do
  root 'home#top'
  get 'home/about', to: 'home#about'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks' # SNS認証時のコールバック処理
  }

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords'
  }

  namespace :public do
    resources :boards, only: %i[new create index edit show update] do
      resource :board_likes, only: %i[create destroy]
      resources :board_comments, only: %i[create destroy edit update destroy] do
        resource :comment_likes, only: %i[create destroy]
      end
      get 'search/search'
    end

    resources :users, only: %i[index show edit update] do
      resources :relationships, only: %i[create destroy]
      get :follows, on: :member
      get :followers, on: :member
    end

    get 'todolists/complete'
    post 'todolists/complete', as: 'todolists_compelte'

    resources :todolists, except: [:show]

    # todolistの中身をリセットさせるために追加
    delete '/todolists_delete', to: 'todolists#empty', as: 'todolists_delete'

    # get 'board_comments/index'
    # get 'board_comments/edit'
  end

  namespace :manage do
    get 'home/top'
    resources :users, except: [:destroy]
    resources :boards, only: %i[index show update]
    resources :todolists, except: [:show]
    resources :tags, except: [:show]

    get 'search/search'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
