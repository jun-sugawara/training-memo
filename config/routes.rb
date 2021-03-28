Rails.application.routes.draw do
  root to: "training_records#index"
  resources :training_records, except: :show
end
