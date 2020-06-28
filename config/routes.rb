Rails.application.routes.draw do
  namespace :admin do
    resources :rounds do
      resources :calls, shallow: true
      resources :cards, shallow: true, only: %i[index create]

      get :screen, on: :member
    end
  end

  resources :cards, only: %i[index create show]

  root "admin/rounds#index"
end
