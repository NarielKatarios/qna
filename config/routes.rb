Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answers, only: [:create, :destroy, :update] do
      post :like
      post :dislike
    end
    post :best_answer
    post :like
    post :dislike
  end

  root to: "questions#index"
end