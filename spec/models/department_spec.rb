require 'spec_helper'

describe Department do
  before { @department = Department.new(name: "Admin", active: true) }

  subject { @department }

  it { should respond_to(:id)}
  it { should respond_to(:name)}
  it { should respond_to(:active)}
  it { should respond_to(:created_at)}
  it { should respond_to(:updated_at)}
end
