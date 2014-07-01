require 'spec_helper'


describe Category do
  before { @category = Category.new(name: "Tutoring", department_id: 1, active: true)}

  subject { @category }

  it { should respond_to(:id)}
  it { should respond_to(:name)}
  it { should respond_to(:department_id)}
  it { should respond_to(:active)}
  it { should respond_to(:created_at)}
  it { should respond_to(:updated_at)}
end
