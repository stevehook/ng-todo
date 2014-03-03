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
  end

  describe 'listing archived todos' do
    let!(:pending_todo) { Todo.create! title: 'Thing 1' }
    let!(:completed_todo) { Todo.create! title: 'Thing 2', completed: true }
    let!(:archived_todo) { Todo.create! title: 'Thing 3', archived: true, completed: true }

    it 'clicking the archive link opens the archived todo page' do
      visit todos_path
      click_link 'Archive'
      current_path.should == archived_todos_path
    end

    it 'shows the list of archived todos' do
      visit archived_todos_path
      expect(page).to have_content 'Thing 3'
    end

    it 'does not show unarchived todos' do
      visit archived_todos_path
      expect(page).to_not have_content 'Thing 1'
      expect(page).to_not have_content 'Thing 2'
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

  describe 'editing a todo' do
    let!(:pending_todo) { Todo.create! title: 'Thing 1' }

    it 'clicking the edit link on a pending todo opens the edit form' do
      visit todos_path
      within "#todo-#{pending_todo.id}" do
        find('.link-edit').click
      end
      current_path.should == edit_todo_path(pending_todo)
    end

    it 'updating a todo changes the title and redirects to the todo list' do
      visit edit_todo_path(pending_todo)
      fill_in :todo_title, with: 'A different thing'
      click_button 'Update'
      pending_todo.reload.title.should == 'A different thing'
      current_path.should == todos_path
    end

    it 'clicking the cancel button does not change the title it just redirects to the todo list' do
      visit edit_todo_path(pending_todo)
      fill_in :todo_title, with: 'A different thing'
      click_link 'Cancel'
      pending_todo.reload.title.should == 'Thing 1'
      current_path.should == todos_path
    end
  end

  describe 'adding a todo' do
    it 'creates a new pending todo' do
      visit todos_path
      fill_in :todo_title, with: 'Another thing'
      within "#todo-new" do
        find("button[type='submit']").click
      end
      todo = Todo.last
      todo.title.should == 'Another thing'
    end
  end

  describe 'archiving a todo' do
    let!(:pending_todo) { Todo.create! title: 'Thing 1' }

    it 'archives a new pending todo' do
      visit todos_path
      within "#todo-#{pending_todo.id}" do
        find('.button-destroy').click
      end
      Todo.where(id: pending_todo.id).first.archived?.should == true
    end
  end
end
