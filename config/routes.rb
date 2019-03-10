Rails.application.routes.draw do
  devise_for :users

  concern :commentable do
    resources :comments
  end

  resources :questions, concerns: :commentable, shallow: true do
    resources :answers, concerns: :commentable, only: [:create, :destroy, :update], shallow: true do
      # resources :comments
      post :like
      post :dislike
    end
    post :best_answer
    post :like
    post :dislike
    # resources :comments
  end

  root to: "questions#index"
end