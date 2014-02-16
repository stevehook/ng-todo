class TodosController < ApplicationController
  def index
    @todos = Todo.unarchived
  end

  def complete
    @todo = Todo.find(params[:id]).complete!
    redirect_to action: :index
  end
end
