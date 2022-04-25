# frozen_string_literal: true

Rails.application.routes.draw do
  resources :on_chain_tokens
  resources :tokens
  resources :chains

  resources :transactions
  resources :purchases, only: %i[new create]
  resources :sales, only: %i[new create]

  resources :overview, only: %i[index]

  root 'overview#index'
end
