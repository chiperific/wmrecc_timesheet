require 'spec_helper'

describe AppDefault do
  let!(:app_default) { FactoryGirl.create(:app_default) }
  subject { app_default }

  it { should respond_to :name }

  it { should be_valid }

  describe "when name is not present" do
    before { app_default.name = "" }

    it { should_not be_valid }
  end
end