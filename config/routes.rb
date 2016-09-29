Rails.application.routes.draw do


  resources :tasks
  get 'relationships/create'

  get 'relationships/destroy'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :blogs do
     collection do
      post :confirm
    end
  end

  resources :blogs do
  resources :comments
end

  resources :contacts, only: [:new, :create] do
    collection do
      post :confirm
    end
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
}
resources :users, only: [:index, :show, :edit, :update] do
  resources :tasks
end
resources :relationships, only: [:create, :destroy]


  root 'top#index'

  if Rails.env.development?
      mount LetterOpenerWeb::Engine, at: "/letter_opener"
    end
end
