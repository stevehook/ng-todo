class TodosController < ApplicationController
  def index
    @todos = Todo.unarchived
    respond_to do |format|
      format.html { @new_todo = Todo.new }
      format.json { render json: @todos }
    end
  end

  def create
    @new_todo = Todo.new(todo_params)
    if @new_todo.save
      respond_to do |format|
        format.html { redirect_to action: :index }
        format.json { render json: @new_todo }
      end
    else
      respond_to do |format|
        format.html { redirect_to action: :index }
        format.json { render json: @new_todo }
      end
    end
  end

  def complete
    @todo = Todo.find(params[:id]).complete!
    respond_to do |format|
      format.html { redirect_to action: :index }
      format.json { render json: @todo }
    end
  end

  def destroy
    Todo.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to action: :index }
      format.json { render json: @todo }
    end
  end

  def edit
    @todo = Todo.find(params[:id])
    respond_to do |format|
      format.html { render :edit }
      format.json { render json: @todo }
    end
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.update_attributes(todo_params)
    respond_to do |format|
      format.html { redirect_to action: :index }
      format.json { render json: @todo }
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title)
  end
end
