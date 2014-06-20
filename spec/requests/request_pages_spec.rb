require 'spec_helper'

describe "Request Pages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  let(:request) { FactoryGirl.create(:request, user_id: user.id, date: "01/01/14", hours: 8, sv_approval: false)}


  describe "New" do
    before { visit new_user_requests(user) }

    it { should have_content(user.fname)}
  end

  describe "Index" do
    before { visit user_requests(user)}

  end

  describe "Edit" do

  end
end