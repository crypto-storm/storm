# frozen_string_literal: true

Rails.application.routes.draw do
  resources :home

  root 'home#index'
end
