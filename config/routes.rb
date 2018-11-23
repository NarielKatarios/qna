Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answers, only: [:create, :destroy, :update] do
      resources :comments
      post :like
      post :dislike
    end
    post :best_answer
    post :like
    post :dislike
    resources :comments
  end

  root to: "questions#index"
end