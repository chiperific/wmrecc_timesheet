require 'spec_helper'

describe Timesheet do
  let(:timesheet) { FactoryGirl.create(:timesheet)}

  subject { timesheet }

  it 'has all the fields' do
    should respond_to(:week_num)
    should respond_to(:year)
  end

  it { should be_valid }

  describe "when week_num is not present" do
    before { timesheet.week_num = nil }
    it { should_not be_valid }
  end

  describe "when week_num" do
    context "is too big" do
      before { timesheet.week_num = 54 }
      it { should_not be_valid }
    end

    describe "is negative" do
      before { timesheet.week_num = -3 }
      it { should_not be_valid}
    end
  end

  describe "when year is not present" do
    before { timesheet.year = nil }
    it { should_not be_valid }
  end

  describe "when year" do
    context "is too short" do
      before { timesheet.year = 1 }
      it { should_not be_valid }
    end

    context "is too long" do
      before { timesheet.year = 200014 }
      it { should_not be_valid }
    end
  end

end