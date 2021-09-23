Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :sponsorships 
  resources :webhooks, only: [:create]

  root 'static_pages#root'
end
