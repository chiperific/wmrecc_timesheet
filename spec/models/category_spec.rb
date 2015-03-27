require 'spec_helper'


RSpec.describe Category do
  category = FactoryGirl.build(:category)
  subject { category }

  it "has all the fields" do
    should respond_to(:id)
    should respond_to(:name)
    should respond_to(:department_id)
    should respond_to(:active)
    should respond_to(:created_at)
    should respond_to(:updated_at)
  end

  describe "when name is not present" do
    before { category.name = ""}
    it { should_not be_valid }
  end

  describe "when department_id is not present" do
    before { category.department_id = nil }
    it { should_not be_valid }
  end

  describe "when active is not present" do
    before { category.active = nil }
    it { should_not be_valid }
  end
end
