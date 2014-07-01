require 'spec_helper'

describe "Request Pages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  let(:request) { FactoryGirl.create(:request)}


  describe "New" do
    before { visit new_user_request_path(user) }

    it { should have_content("Submit time off requests")}
    it { should have_button("Submit")}

    ## with invalid info

    ## with valid info
  end

  describe "Index" do
    before { visit user_requests_path(user)}

    it { should have_content("WMRECC Timesheet")}

  end

  describe "Edit" do
    before { visit edit_user_request_path(user, request) }

    it { should have_content("Submit time off requests")}
    it { should have_button("Submit")}

    ## with invalid info

    ## with valid info
  end
end