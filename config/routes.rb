Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answers, only: [:create, :destroy]
  end
  # resources :users do
  #   resources :questions
  #   resources :answers
  # end

  root to: "questions#index"

end