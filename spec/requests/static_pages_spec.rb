require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home" do
    before { visit root_path }

    it 'has page elements' do
      should have_title('Home')
      should have_content('Timekeeper')
    end

    context "When not signed in" do
      it { should have_content 'Sign in to continue'}

      describe "should allow you to login" do
        let!(:user) { FactoryGirl.create(:user) }
        let!(:current_user) {user}
        before do
          fill_in 'static_page_email', with: user.email
          fill_in 'static_page_password', with: user.password
          click_button 'Sign in'
        end

        it { should have_content 'Welcome' }
      end
    end

    context "When signed in" do
      let!(:user) { FactoryGirl.create(:user) }
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

  end #describe 'Home'

  describe "Help page" do
    let!(:user) { FactoryGirl.create(:user) }
    before do
      sign_in(user)
      visit help_path
    end

    it { should have_title('Help') }
    it { should have_link('Email the IT Department')}
  end

  describe "Configure page" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:app_default) { FactoryGirl.create(:app_default) }
    before do
      sign_in(user)
      visit configure_path
    end

    it { should have_title('Configure') }
    it { should have_content('System Configuration') }
  end

end
