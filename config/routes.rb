PatentScraper::Application.routes.draw do

  root to: 'pages#root'

  match '/scrape', to: 'pages#scrape', via: [:post, :get]
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

end
