require 'spec_helper'

RSpec.describe TimesheetHour do
  timesheet_hour = FactoryGirl.build_stubbed(:timesheet_hour)

  subject { timesheet_hour }

  it "has all the fields" do
    should respond_to(:timesheet_id)
    should respond_to(:day_num)
    should respond_to(:hours)
    should respond_to(:timeoff_hours)
    should respond_to(:created_at)
    should respond_to(:updated_at)
  end

  describe "when day_num" do
    context "is not present" do
      before { timesheet_hour.day_num = nil }
      it { should_not be_valid }
    end

    context "is negative" do
      before { timesheet_hour.day_num = -2 }
      it { should_not be_valid }
    end

    context "is too large" do
      before { timesheet_hour.day_num = 8 }
      it { should_not be_valid }
    end
  end

  describe "when hours" do
    context "is not present" do
      before { timesheet_hour.hours = nil }
      it { should_not be_valid }
    end

    context "is negative" do
      before { timesheet_hour.hours = -22 }
      it { should_not be_valid }
    end

    context "is too large" do
      before { timesheet_hour.hours = 25 }
      it { should_not be_valid }
    end
  end

  describe "when timeoff_hours" do
    context "is not present" do
      before { timesheet_hour.timeoff_hours = nil }
      it { should_not be_valid }
    end

    context "is negative" do
      before { timesheet_hour.timeoff_hours = -22 }
      it { should_not be_valid }
    end

    context "is too large" do
      before { timesheet_hour.timeoff_hours = 25 }
      it { should_not be_valid }
    end
  end

end
