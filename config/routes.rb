# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins
  devise_for :users


  #   devise_for :admins, controllers: {
  #   sessions:      'admins/sessions',
  #   passwords:     'admins/passwords',
  #   registrations: 'admins/registrations'
  # }
  #
  # devise_for :admin, skip: :all
  #   devise_scope :admin do
  #     get 'admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
  #     post 'admins/sign_in' => 'admins/sessions#create', as: 'admin_session'
  #     delete 'admins/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'
  #   end

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
