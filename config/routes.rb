Rails.application.routes.draw do
  resources :rounds do
    resources :calls, shallow: true

    get :screen, on: :member
  end

  root "rounds#index"
end
