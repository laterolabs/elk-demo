Rails.application.routes.draw do
  resources :stores
  resources :carts, only: [:show, :create] do
    collection do
      post :checkout
    end
  end
end
