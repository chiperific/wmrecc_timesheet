require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_title('Home')}
    it { should have_content('WMRECC Timesheet')}
    it { should_not have_link('Home')}

    it "should allow you to login" do
      within(root_path) do
      fill_in 'Username', with: 'it@westmirefugee.org'
      fill_in 'Password', with: 'wmrecc09'
    end
    click_link 'Sign in'
    expect(page).to have_content 'Success'
    end
  end

  describe "Help page" do
    before { visit help_path}

    it { should have_title('Help')}
    it { should have_link('Email the IT Department')}
  end

end
