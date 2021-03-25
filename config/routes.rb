Rails.application.routes.draw do
  get 'training_records/index'
  root to: "training_records#index"
end
