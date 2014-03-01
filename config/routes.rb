NgTodo::Application.routes.draw do
  resources :todos, only: [:index, :create, :destroy, :edit, :update] do
    member do
      patch 'complete'
    end
    collection do
      get 'archived'
    end
  end
  root 'todos#index'
end
