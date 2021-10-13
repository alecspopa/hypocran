Rails.application.routes.draw do
  root to: "packages#index"
  resources :packages
end
