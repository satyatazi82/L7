Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/" => "home#index"

  get "todos", to: "todos#index"
  post "todos", to: "todos#create"
  get "todos/:id", to: "todos#show"
  patch "todos/:id", to: "todos#update"
  delete "todos/:id", to: "todos#delete"

  resources "users"

  get "signin" => "sessions#index"
  post "signin" => "sessions#create"
  delete "signout" => "sessions#destroy"
end
