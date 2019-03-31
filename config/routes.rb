Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }


  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  concern :commentable do
    resources :comments
  end

  resources :questions, concerns: :commentable, shallow: true do
    resources :answers, concerns: :commentable, only: %i[create destroy update], shallow: true do
      post :like
      post :dislike
    end
    post :best_answer
    post :like
    post :dislike
  end

  root to: 'questions#index'
end
