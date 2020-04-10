Rails.application.routes.draw do
  resources :rounds do
    resources :calls, shallow: true
  end
end
