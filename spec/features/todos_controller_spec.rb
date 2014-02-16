require 'spec_helper'

describe '#index' do
  let!(:pending_todo) { Todo.create! title: 'Thing 1' }
  let!(:completed_todo) { Todo.create! title: 'Thing 2', completed: true }
  let!(:archived_todo) { Todo.create! title: 'Thing 3', archived: true, completed: true }

  describe 'listing todos' do
    it 'shows the list of todos' do
      visit todos_path
      expect(page).to have_content 'Thing 1'
      expect(page).to have_content 'Thing 2'
    end

    it 'does not show archived todos' do
      visit todos_path
      expect(page).to_not have_content 'Thing 3'
    end

    it 'shows a tick mark for the completed todo'
  end

  describe 'clicking the complete icon on a todo' do
    it 'completes the todo' do
      visit todos_path
      within "#todo-#{pending_todo.id}" do
        click_button ''
      end
      expect(pending_todo.reload.completed?).to be_true
      expect(current_path).to eql(todos_path)
    end
  end

  describe 'adding a todo' do
  end

  describe 'archiving todos' do
  end
end
