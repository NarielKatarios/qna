Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answers, only: :create
  end
  #resources :users

  root to: "questions#index"

end