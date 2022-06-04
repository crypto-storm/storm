# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  mount Sidekiq::Web, at: '/sidekiq'

  resources :tokens
  resources :chains

  resources :transactions
  resources :purchases, only: %i[new create edit update]
  resources :sales, only: %i[new create edit update]

  resources :overview, only: %i[index]
  resources :charts, only: %i[create]
  resources :portfolios do
    collection do
      put :change_active
    end
  end

  root 'overview#index'
end
