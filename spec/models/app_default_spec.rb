require 'spec_helper'

RSpec.describe AppDefault do
  app_default = FactoryGirl.build(:app_default)
  subject { app_default }

  it { should respond_to :name }

  it { should be_valid }

  describe "when name is not present" do
    before { app_default.name = "" }

    it { should_not be_valid }
  end
end