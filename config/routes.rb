NgTodo::Application.routes.draw do
  resources :todos, only: [:index, :create] do
    member do
      patch 'complete'
    end
  end
  root 'todos#index'
end
