class TodosController < ApplicationController
  def index
    @todos = Todo.unarchived
  end
end
