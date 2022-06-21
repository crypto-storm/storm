# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  mount Sidekiq::Web, at: '/sidekiq'

  resources :tokens, except: %i[show]
  resources :chains, except: %i[show]
  resources :exchanges, except: %i[show]

  resources :transactions, except: %i[show]
  resources :purchases, only: %i[new create edit update]
  resources :sales, only: %i[new create edit update]

  resources :overview, only: %i[index]
  resources :charts, only: %i[create]
  resources :portfolios, except: %i[index show] do
    collection do
      put :change_active
    end
  end

  root 'overview#index'
end
