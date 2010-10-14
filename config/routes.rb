Foosball::Application.routes.draw do
  resources :bagels
  resources :players do
    collection do
      get 'names'
      post 'names'
    end
  end

  root :to => 'bagels#home'
end