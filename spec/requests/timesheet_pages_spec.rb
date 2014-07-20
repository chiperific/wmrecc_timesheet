require 'spec_helper'
require 'support/utilities'

describe "Timesheet Pages" do
  let(:user) { FactoryGirl.create(:user) }
  let(:timesheet) { FactoryGirl.create(:timesheet) }
  let(:timesheet_hour) { FactoryGirl.create(:timesheet_hour) }
  let(:timesheet_category) { FactoryGirl.create(:timesheet_category) }

  subject { page }

  pending "Index" do
    # _single_timesheet_table is not loading because th.timesheet == nil
    before do
      visit user_timesheets_path(user)
    end

    it { should have_content("Timesheets") }

  end

  describe "New" do
  end

  describe "Edit" do
  end

  describe "Report" do
  end
  
end