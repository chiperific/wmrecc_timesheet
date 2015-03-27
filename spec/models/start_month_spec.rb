require 'spec_helper'

RSpec.describe StartMonth do
  start_month = FactoryGirl.build(:start_month)

  subject { start_month }

  it 'has all the fields' do
    should respond_to(:month)
    should respond_to(:app_default_id)
  end

  it { should be_valid }

  describe "when month is not present" do
    before { start_month.month = ""}
    it { should_not be_valid }
  end

  describe "when month is not a month" do
    before { start_month.month = "Thursday" }
    it { should_not be_valid }
  end

  describe "when app_default_id is not present" do
    before { start_month.app_default_id = nil }
    it { should_not be_valid }
  end
end
