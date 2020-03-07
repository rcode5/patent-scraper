# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#root'

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  match '/scrape', to: 'pages#scrape', via: [:post]
  match '/query', to: 'pages#query', via: [:post]

  resources :patent_queries, only: %i[create show destroy]
  resources :patents, only: %i[show create]
end
