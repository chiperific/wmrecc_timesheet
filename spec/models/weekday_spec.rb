require 'spec_helper'

RSpec.describe Weekday do
  weekday = FactoryGirl.build_stubbed(:weekday)
  subject { weekday }

  it "has all the fields" do
    should respond_to :name
    should respond_to :abbr
    should respond_to :app_default_id
    should respond_to :day_num
  end

  it { should be_valid }

  describe "when name is not present" do
    before { weekday.name = "" }
    it { should_not be_valid }
  end

  describe "when name is not actuall a day" do
    before { weekday.name = "Frisday" }
    it { should_not be_valid}
  end

  describe "when name is actuall a day" do
    before { 
      weekday.name = "Saturday" 
      weekday.abbr = "Sat"
      weekday.day_num = 6
      weekday.app_default_id = 1
    }
    
    it { should be_valid }
  end

  describe "when abbr is not present" do
    before { weekday.abbr = "" }
    it { should_not be_valid }
  end

  describe "when app_default_id is not present" do
    before { weekday.app_default_id = nil }
    it { should_not be_valid }
  end

  describe "when day_num is not present" do 
    before { weekday.day_num = nil }
    it { should_not be_valid }
  end

end