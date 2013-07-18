Foosball::Application.routes.draw do
  get "players/all" => "players#all"

  resources :bagels
  resources :players do
    collection do
      get "names"
      post "names"
    end
  end

  root :to => "bagels#home"
  get "sign_in" => "sign_in#index"
  post "sign_in" => "sign_in#create"
  get "home" => "bagels#home"
end
