require 'spec_helper'
require 'support/utilities'

RSpec.describe "Static pages" do
  subject { page }

  describe "Home" do
    before { visit root_path }

    it 'has page elements' do
      should have_title('Home')
    end

    context "When not signed in" do
      it { should have_content 'Sign in to continue'}

      describe "should allow you to login" do
        user = FactoryGirl.build(:user)
        before do
          fill_in 'static_page_email', with: user.email
          fill_in 'static_page_password', with: user.password
          click_button 'Sign in'
        end

        it { should have_content 'Welcome' }
      end
    end

    context "When signed in" do
      user = FactoryGirl.build(:user)
      before { sign_in(user) }

      it 'has page elements' do
        should have_title('Home')
        should have_content('Welcome')
        should have_link('Submit timesheet')
      end

      describe "should allow you to sign out" do
        before { click_link('Sign out') }

        it { should have_content 'Sign in to continue'}
      end
    end

  end #RSpec.describe 'Home'

  describe "Help page" do
    user = FactoryGirl.build(:user)
    before do
      sign_in(user)
      visit help_path
    end

    it { should have_title('Help') }
    it { should have_link('Email the IT Department')}
  end

  describe "Configure page" do
    user = FactoryGirl.build(:user)
    before do
      sign_in(user)
      visit configure_path
    end

    it 'has all the elements' do
      should have_title('Configure')
      should have_content('System Configuration')
      should have_content('Weekdays')
      should have_content('Start of Year')
      should have_content('Timeoff accrual')
      should have_content('Pay Period')
      should have_content('Contacting IT')
      should have_content('Holidays')
    end
  end

  describe "Payroll page" do
    user = FactoryGirl.build(:user)
    before do
      sign_in(user)
      visit payroll_path
    end

    it 'has all the elements' do
      should have_title('Payroll')
      should have_content('Payroll')
      should have_content('Staff:')
      should have_content('Categories:')
    end
  end

end
