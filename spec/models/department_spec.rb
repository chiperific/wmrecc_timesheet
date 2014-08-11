require 'spec_helper'

describe Department do
  let!(:department) { FactoryGirl.create(:department)}

  subject { department }

  it "has all the fields" do
    should respond_to(:name)
    should respond_to(:active)
  end

  describe "when name is not present" do
    before { department.name = "" }

    it { should_not be_valid }
  end

  describe "when active is not present" do
    before { department.active = nil }

    it { should_not be_valid }
  end

end
