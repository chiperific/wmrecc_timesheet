require 'spec_helper'

describe "Static pages" do

  describe "Home page" do
    it "should have the content 'Timesheet Home'" do
      visit '/'
      expect(page).to have_title('Home')
      expect(page).to have_content('WMRECC Timesheet')
    end
    it "should allow you to login" do
      visit '/'
      within("static_pages#home") do
      fill_in 'Login', with: 'it@westmirefugee.org'
      fill_in 'Password', with: 'wmrecc09'
    end
    click_link 'Sign in'
    expect(page).to have_content 'Success'
    end
  end

  describe "Help page" do
    it "should have the content 'Timesheet Help'" do
      visit '/help'
      expect(page).to have_title ('Help')
    end
    it "should have a link to email the IT email" do
      visit '/help'
      expect(page).to have_link ('Mail the IT Department')
    end
  end

end
