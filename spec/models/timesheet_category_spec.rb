require 'spec_helper'

describe TimesheetCategory do
  let(:timesheet_category) { FactoryGirl.create(:timesheet_category)}

  subject { timesheet_category }

  it 'has all the fields' do
    should { respond_to(:timesheet_id)}
    should { respond_to(:user_id)}
    should { respond_to(:category_id)}
    should { respond_to(:hours)}
    should { respond_to(:approved)}
  end

  it { should be_valid }

  describe "when timesheet_id is not present" do
    before { timesheet_category.timesheet_id = nil }
    it { should_not be_valid }
  end

  describe "when user_id is not present" do
    before { timesheet_category.user_id = nil }
    it { should_not be_valid }
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
      before { timesheet_category.hours = 25 }
      it { should_not be_valid }
    end
  end  
end
