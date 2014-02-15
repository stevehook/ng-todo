require 'spec_helper'

describe Todo do
  [:title, :completed?, :archived?, :order].each do |attribute|
    it { should respond_to attribute }
  end

  it { should validate_presence_of :title }
end
