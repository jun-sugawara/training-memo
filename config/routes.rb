Rails.application.routes.draw do
  get 'body_records/index'
  root to: "training_records#index"
  resources :training_records, except: :show
end
