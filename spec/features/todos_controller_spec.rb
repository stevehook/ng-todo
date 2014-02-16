require 'spec_helper'

describe '#index' do
  before do
    Todo.create! title: 'Thing 1'
    Todo.create! title: 'Thing 2', completed: true
    Todo.create! title: 'Thing 3', archived: true, completed: true
  end

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

  describe 'finishing a todo' do
  end

  describe 'adding a todo' do
  end

  describe 'archiving todos' do
  end
end
