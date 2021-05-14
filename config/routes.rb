Rails.application.routes.draw do
  devise_for :users
  root to: "top#index"
  resources :body_records do
    collection do
      post :search
      post :graph
      post :month_graph
      post :week_graph
    end
  end
  resources :users
  resources :training_records do
    collection do
      post :next
      post :search
      post :max
      post :max_search
    end
  end
end
