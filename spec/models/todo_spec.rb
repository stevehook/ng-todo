require 'spec_helper'

describe Todo do
  [:title, :completed?, :archived?, :order].each do |attribute|
    it { should respond_to attribute }
  end

  it { should validate_presence_of :title }

  it 'initialises the complete_by date' do
    subject.complete_by.should == (Date.today + 1.day)
  end
end
