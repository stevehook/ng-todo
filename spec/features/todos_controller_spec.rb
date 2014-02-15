require 'spec_helper'

describe '#index' do
  before do
    Todo.create! title: 'Thing 1'
    Todo.create! title: 'Thing 2'
    Todo.create! title: 'Thing 3', archived: true
  end

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
