Rails.application.routes.draw do
  namespace :admin do
    resources :rounds do
      resources :calls, shallow: true
      resources :cards, shallow: true, only: %i[index create]

      get :screen, on: :member
    end
  end

  root "admin/rounds#index"
end
