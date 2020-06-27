Rails.application.routes.draw do

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

  root 'home#top'
  get 'home/about'

  namespace :public do
    resources :boards, only: %i[new create index edit show update] do
      #resource :board_likes, only: [:create, :destroy]
      resources :board_comments, only: [:create, :destroy] do
        resource :comment_likes, only: [:create, :destroy]
      end
    end

    #ここのところ修正
    #resources :board_comments, only: [:destroy]

    resources :relationships, only: %i[create destroy]

    resources :users, only: %i[index show edit update]

    get 'todolists/complete'
    get 'board_comments/index'
    get 'board_comments/edit'
  end

  namespace :manage do
    get 'home/top'
    resources :users, except: [:destroy]
    resources :boards, only: %i[index show update]

    resources :tags, except: [:show]

    get 'search/search'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
