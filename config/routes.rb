# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  root 'home#top'
  get 'home/about'

  namespace :user do
    resources :users, only: %i[index show edit]
    resources :boards, only: %i[new index show edit]
    get 'todolists/complete'
  end

  # namespace :public do
  #   resources :boards, only: %i[new create index show edit]

# get 'board_comments/index'
  # get 'board_comments/edit'
  # end
  #
    namespace :public do
      resources :boards, only: %i[new create index show edit]

      get 'board_comments/index'
      get 'board_comments/edit'
  end

  namespace :admin do
    get 'home/top'
    resources :users, except: [:destroy]
    resources :boards, only: %i[index show update]

    resources :tags, except: [:show]

    get 'search/search'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
