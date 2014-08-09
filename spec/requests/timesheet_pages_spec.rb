require 'spec_helper'
require 'support/utilities'

describe "Timesheet Pages" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:users_staff) { FactoryGirl.create(:users_staff) }
  let!(:timesheet) { FactoryGirl.create(:timesheet) }
  let!(:timesheet_hour) { FactoryGirl.create(:timesheet_hour) }
  let!(:timesheet_category) { FactoryGirl.create(:timesheet_category) }
  before { sign_in(user) }

  subject { page }

  describe "Single" do
    before do
      visit user_timesheets_single_path(user)
    end
    it { should have_content("Timesheet") }

  end

  describe "Supervisor" do
    before do
      visit user_timesheets_supervisor_path(user)
    end
    it { should have_content("Your Team's Timesheets") }

  end

  describe "Admin" do
    before do
      visit user_timesheets_admin_path(user)
    end
    it { should have_content("All Users' Timesheets") }

  end

  describe "New" do
  end

  describe "Edit" do
  end

  describe "Report" do
  end
  
end