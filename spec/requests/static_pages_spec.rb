require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home" do
    before { visit root_path }

    it { should have_title('Home')}
    it { should have_content('WMRECC Timesheet')}
    it { should_not have_link('Home')}

    describe "should allow you to login" do
      fill_in 'Username', with: 'chip@kragt.com'
      fill_in 'Password', with: 'foobar'
      click_link 'Sign in'
      expect(page).to have_content 'Success'
    end

    describe "should allow you to logout"
  end

  describe "Help page" do
    before { visit help_path}

    it { should have_title('Help')}
    it { should have_link('Email the IT Department')}
  end

end
