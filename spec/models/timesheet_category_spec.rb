require 'spec_helper'

RSpec.describe TimesheetCategory do
  timesheet_category = FactoryGirl.build_stubbed(:timesheet_category)

  subject { timesheet_category }

  it 'has all the fields' do
    should respond_to(:timesheet_id)
    should respond_to(:category_id)
    should respond_to(:hours)
    should respond_to(:created_at)
    should respond_to(:updated_at)
  end

  it { should be_valid }

  describe "when timesheet_id is not present" do
    before { 
      timesheet_category.timesheet_id = nil
      timesheet_category.hours = 7
      timesheet_category.category_id = 1
    }

    it { should be_valid }
  end

  describe "when category_id is not present" do
    before { timesheet_category.category_id = nil }
    it { should_not be_valid }
  end

  describe "when hours" do
    context "is not present" do
      before { timesheet_category.hours = nil }
      it { should_not be_valid }
    end

    context "is negative" do
      before { timesheet_category.hours = -22 }
      it { should_not be_valid }
    end

    context "is too large" do
      before { timesheet_category.hours = 185 }
      it { should_not be_valid }
    end
  end  
end
