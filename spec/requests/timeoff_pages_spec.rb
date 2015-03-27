require 'spec_helper'
require 'support/utilities'

RSpec.describe 'Timeoff Pages' do
  user = FactoryGirl.build(:user)
  FactoryGirl.build(:timeoff_accrual)
  before { sign_in(user) }

  subject { page }
  
  describe "Admin page" do
    before { visit user_timeoff_admin_path(user) }

    it "should have certain content" do
      should have_title 'Timeoff'
      should have_content 'Timeoff'
      should have_table 'timeoff_table'
    end
  end

  describe "Single page" do
    before { visit user_timeoff_single_path(user) }

    it "should have certain content" do
      should have_title 'Timeoff'
      should have_content 'Timeoff'
      should have_button 'Submit'
      should have_table 'timeoff_table'
    end
  end

  describe "Supervisor page" do
    before { visit user_timeoff_supervisor_path(user) }

    it "should have certain content" do
      should have_title 'Timeoff'
      should have_table 'timeoff_table'
      should have_content 'Timeoff'
    end
  end
end