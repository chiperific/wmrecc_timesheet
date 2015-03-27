require 'spec_helper'
require 'support/utilities'

RSpec.describe "Timesheet Pages" do
  user = FactoryGirl.build(:user)
  timesheet = FactoryGirl.build(:timesheet)
  
  before { sign_in(user) }

  subject { page }

  describe "Single" do
    before { visit user_timesheets_single_path(user) }

    it { should have_content("Timesheet") }
    
  end

  describe "Supervisor" do
    before { visit user_timesheets_supervisor_path(user) }
    it { should have_content("Your Team's Timesheets") }

  end

  describe "Admin" do
    before { visit user_timesheets_admin_path(user) }
    it { should have_content("All Users' Timesheets") }

  end

  describe "New" do
    before { visit new_user_timesheet_path(user) }
    it { should have_content('New Timesheet for')}
    it { should have_title('New Timesheet')}
  end

  describe "Edit" do
    before { visit edit_user_timesheet_path(user, timesheet) }
    it { should have_content('Edit Timesheet for')}
    it { should have_title('Edit Timesheet')}
  end
  
end