Rails.application.routes.draw do
  root to: "top#index"
  resources :training_records, except: :show
  resources :body_records
end
