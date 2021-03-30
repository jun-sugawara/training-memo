Rails.application.routes.draw do
  devise_for :users
  root to: "top#index"
  resources :training_records, except: :show
  resources :body_records
end
