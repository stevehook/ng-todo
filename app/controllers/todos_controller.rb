class TodosController < ApplicationController
  def index
    @todos = Todo.unarchived
    @new_todo = Todo.new
  end

  def create
    @new_todo = Todo.new(todo_params)
    if @new_todo.save
      redirect_to action: :index
    else
      @todos = Todo.unarchived
      render :index
    end
  end

  def complete
    @todo = Todo.find(params[:id]).complete!
    redirect_to action: :index
  end

  private

  def todo_params
    params.require(:todo).permit(:title)
  end
end
