Foosball::Application.routes.draw do
  match '/' => redirect("http://protestsopa.org")
  match '*players' => redirect("http://protestsopa.org")
  match '*bagels' => redirect("http://protestsopa.org")

  get 'players/all' => 'players#all'

  resources :bagels
  resources :players do
    collection do
      get 'names'
      post 'names'
    end
  end

  root :to => 'bagels#home'
  get 'sign_in' => 'sign_in#index'
  post 'sign_in' => 'sign_in#create'
end
