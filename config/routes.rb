Rails.application.routes.draw do
  devise_for :users
  resources :jogging_times
  get "up" => "rails/health#show", as: :rails_health_check

  
  root "jogging_times#index"
end
