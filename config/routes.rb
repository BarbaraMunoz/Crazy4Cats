Rails.application.routes.draw do
  get 'welcome/index'
  get 'profile/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :posts do
    member do
      patch :upvote
      patch :downvote
    end
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  resources :profiles, only: [:show]


  root 'welcome#index'
end

