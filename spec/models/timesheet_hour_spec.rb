require 'spec_helper'

describe TimesheetHour do
  let(:timesheet_hour) { FactoryGirl.create(:timesheet_hour)}

  subject { timesheet_hour }

  it "has all the fields" do
    should respond_to(:timesheet_id)
    should respond_to(:user_id)
    should respond_to(:weekday)
    should respond_to(:hours)
    should respond_to(:approved)
  end

  describe "when timesheet_id is not present" do
    before { timesheet_hour.timesheet_id = nil }
    it { should be_valid }
  end

  describe "when user_id is not present" do
    before { timesheet_hour.user_id = nil }
    it { should_not be_valid }
  end

  describe "when weekday" do
    context "is not present" do
      before { timesheet_hour.weekday = nil }
      it { should_not be_valid }
    end

    context "is negative" do
      before { timesheet_hour.weekday = -2 }
      it { should_not be_valid }
    end

    context "is too large" do
      before { timesheet_hour.weekday = 8 }
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

end
