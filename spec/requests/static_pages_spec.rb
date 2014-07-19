require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home" do
    before { visit root_path }

    it 'has page elements' do
      should have_title('Home')
      should have_content('Timekeeper')
      should_not have_link('Home')
    end

    describe "should allow you to login" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        visit root_path
        fill_in 'static_page_email', with: user.email
        fill_in 'static_page_password', with: 'foobar'
        click_button 'Sign in'
      end

      it { should have_content 'Welcome' }
    end

    

    describe "should allow you to logout"
  end

  describe "Help page" do
    before { visit help_path}

    it { should have_title('Help')}
    it { should have_link('Email the IT Department')}
  end

end
