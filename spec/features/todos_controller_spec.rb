require 'spec_helper'

describe '#index' do
  describe 'listing todos' do
    let!(:pending_todo) { Todo.create! title: 'Thing 1' }
    let!(:completed_todo) { Todo.create! title: 'Thing 2', completed: true }
    let!(:archived_todo) { Todo.create! title: 'Thing 3', archived: true, completed: true }

    it 'shows the list of todos' do
      visit todos_path
      expect(page).to have_content 'Thing 1'
      expect(page).to have_content 'Thing 2'
    end

    it 'does not show archived todos' do
      visit todos_path
      expect(page).to_not have_content 'Thing 3'
    end

    it 'shows a tick mark for the completed todo' do
    end
  end

  describe 'clicking the complete icon on a todo' do
    let!(:pending_todo) { Todo.create! title: 'Thing 1' }

    it 'completes the todo' do
      visit todos_path
      within "#todo-#{pending_todo.id}" do
        find('.button-complete').click
      end
      expect(pending_todo.reload.completed?).to be_true
      expect(current_path).to eql(todos_path)
    end
  end

  describe 'adding a todo' do
    it 'creates a new pending todo' do
      visit todos_path
      fill_in :todo_title, with: 'Another thing'
      click_button 'Add'
      todo = Todo.last
      todo.title.should == 'Another thing'
    end
  end

  describe 'deleting a todo' do
    let!(:pending_todo) { Todo.create! title: 'Thing 1' }

    it 'creates a new pending todo' do
      visit todos_path
      within "#todo-#{pending_todo.id}" do
        find('.button-destroy').click
      end
      Todo.where(id: pending_todo.id).first.should be_nil
    end
  end

  describe 'archiving todos' do
  end
end
