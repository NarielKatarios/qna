Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answers, only: [:create, :destroy, :update]
    post :best_answer
  end

  root to: "questions#index"
end