# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  # devise_for :users, controllers: {
  #   sessions:      'users/sessions',
  #   passwords:     'users/passwords',
  #   registrations: 'users/registrations'
  # }

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }

  root 'home#top'
  get 'home/about'

  namespace :public do
    resources :boards, only: %i[new create index show edit]
    resources :users, only: %i[index show edit]
    resources :boards, only: %i[new index show edit]
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
