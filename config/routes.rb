# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  mount Sidekiq::Web, at: '/sidekiq'

  resources :on_chain_tokens
  resources :tokens
  resources :chains

  resources :transactions
  resources :purchases, only: %i[new create]
  resources :sales, only: %i[new create]

  resources :overview, only: %i[index]
  resources :charts, only: %i[create]

  root 'overview#index'
end
