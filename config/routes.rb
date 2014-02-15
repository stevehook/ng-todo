NgTodo::Application.routes.draw do
  resources :todos, only: [:index]
  root 'todos#index'
end
