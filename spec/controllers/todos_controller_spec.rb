require 'spec_helper'

describe TodosController do
  describe '#index' do
    context 'with nothing todo' do
      it 'returns an empty list of todos' do
        xhr :get, :index, format: :json
        response.body.should == '[]'
      end
    end

    context 'with three todos, including one archived' do
      let!(:pending_todo) { Todo.create! title: 'Thing 1' }
      let!(:completed_todo) { Todo.create! title: 'Thing 2', completed: true }
      let!(:archived_todo) { Todo.create! title: 'Thing 3', archived: true, completed: true }

      it 'returns a list of todos the unarchived todos' do
        xhr :get, :index, format: :json
        response.body.should == [pending_todo, completed_todo].to_json
      end
    end
  end

  describe '#create' do
    it 'creates a new todo object' do
      xhr :get, :create, todo: { title: 'Walk the dog' }, format: :json
      response.code.should == '200'
      Todo.first.title.should == 'Walk the dog'
    end

    pending 'with a missing title'
  end

  describe '#complete' do
    let!(:pending_todo) { Todo.create! title: 'Thing 1' }

    it 'sets the completed flag of the given todo' do
      xhr :patch, :complete, id: pending_todo.id, format: :json
      pending_todo.reload.completed?.should == true
      response.code.should == '200'
    end

    it 'returns 404 for a missing todo' do
      pending
      xhr :patch, :complete, id: (1 + pending_todo.id), format: :json
      pending_todo.reload.completed?.should == false
      response.code.should == '404'
    end
  end

  describe '#destroy' do
    let!(:pending_todo) { Todo.create! title: 'Thing 1' }

    it 'deletes the given todo' do
      xhr :delete, :destroy, id: pending_todo.id, format: :json
      Todo.where(id: pending_todo.id).count.should == 0
      response.code.should == '200'
    end

    it 'returns 404 for a missing todo' do
      pending
      xhr :delete, :destroy, id: (1 + pending_todo.id), format: :json
      Todo.where(id: pending_todo.id).count.should == 1
      response.code.should == '404'
    end
  end
end
