Rails.application.routes.draw do
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
    get '/users/password', to: 'devise/passwords#new'
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  get 'home/about'
  get 'weekly_report', to: 'jogging_times#weekly_report'
  devise_for :users
  resources :jogging_times
  resources :users, only: [:index, :edit, :update, :destroy, :show]

  root "jogging_times#index"
end
