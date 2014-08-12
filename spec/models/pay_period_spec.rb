require 'spec_helper'

describe PayPeriod do
  let!(:pay_period) { FactoryGirl.create(:pay_period) }
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
    before { pay_period.period_type = "Weekly" }
    it { should be_valid }
  end

  describe "when app_default_id is not present" do
    before { pay_period.app_default_id = nil }
    it { should_not be_valid }
  end

end
