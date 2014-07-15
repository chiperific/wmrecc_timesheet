require 'spec_helper'
require 'support/utilities'

describe "Timesheet Pages" do
  let(:user) { FactoryGirl.create(:user) }
  let(:timesheet) { FactoryGirl.create(:timesheet) }
  let(:timesheet_hour) { FactoryGirl.create(:timesheet_hour) }
  let(:timesheet_category) { FactoryGirl.create(:timesheet_category) }

  subject { page }

  describe "Index" do
    before { visit user_timesheets_path(user) }

    it "has content" do
      should have_content "Recent Timesheets"
      should have_link "View Past"
      should have_link "Edit"
      should have_button "New"
    end
  end

  describe "New" do
  end

  describe "Edit" do
  end

  describe "Report" do
  end
  
end