require 'spec_helper'

RSpec.describe Holiday do
  holiday = FactoryGirl.build(:holiday)

  subject { holiday }

  it 'has all the fields' do
    should respond_to(:name)
    should respond_to(:month)
    should respond_to(:day)
    should respond_to(:app_default_id)
    should respond_to(:created_at)
    should respond_to(:updated_at)
    should respond_to(:floating)
    should respond_to(:float_week)
    should respond_to(:float_day)
  end

  it { should be_valid }

  describe "when name is not present" do
    before { holiday.name = ' ' }
    it { should_not be_valid }
  end

  describe "when month is not present" do
    before { holiday.month = '' }
    it { should_not be_valid }
  end
end
