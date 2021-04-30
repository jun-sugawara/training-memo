Rails.application.routes.draw do
  devise_for :users
  root to: "top#index"
  resources :body_records do
    collection do
      post :search
    end
  end
  resources :users
  resources :training_records do
    collection do
      post :next
      # post :confirm
    end
  end
end
