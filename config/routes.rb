Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "game#index"
  resources :game, only: %i[create show update]
  resources :moves, only: %i[create]

end
