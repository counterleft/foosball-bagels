Foosball::Application.routes.draw do
  resources :bagels
  resources :players

  root :to => "bagels#home"
  get "sign_in" => "sign_in#index"
  post "sign_in" => "sign_in#create"
  get "home" => "bagels#home"
end
