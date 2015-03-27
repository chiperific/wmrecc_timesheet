require 'spec_helper'

RSpec.describe PayPeriod do
  pay_period = FactoryGirl.build(:pay_period)
  subject { pay_period }

  it "has all the fields" do
    should respond_to(:period_type)
    should respond_to(:app_default_id)
  end

  describe "when period_type is not present" do
    before { pay_period.period_type = nil }
    it { should_not be_valid }
  end

  describe "when period_type is not from list" do
    before { pay_period.period_type = "Never!" }
    it { should_not be_valid }
  end

  describe "when period_type is on the list" do
    before { 
      pay_period.period_type = "Weekly"
      pay_period.app_default_id = 1
    }
    it { should be_valid }
  end

  describe "when app_default_id is not present" do
    before { pay_period.app_default_id = nil }
    it { should_not be_valid }
  end

end
