Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
  get 'fifteen/main'
  get 'fifteen/input'
  get 'fifteen/game'
  post 'fifteen/game'
  post 'fifteen/data'
  get 'fifteen/data'
  get 'fifteen/result'
  post 'fifteen/result'

  get 'session/login'

  post 'session/create'

  get 'session/create'

  get 'session/logout'

  resources :users
  root to: 'fifteen#main'
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
