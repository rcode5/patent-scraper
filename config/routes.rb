PatentScraper::Application.routes.draw do

  root to: 'pages#root'

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  match '/scrape', to: 'pages#scrape', via: [:post]

  resources :patent_queries, only: [:create, :show, :destroy]
  resources :patents, only: [:show, :create]
end
