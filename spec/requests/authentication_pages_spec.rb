require 'spec_helper'

describe "Authentication Pages" do
  subject { page }

  describe "signin view" do
    before { visit signin_path }

    it { should have_content('Sign in to continue') }
    it { should have_title('Sign in') }

    describe "signin" do
      before { visit signin_path }

      describe "with invalid information" do
        before { click_button "Sign in" }

        it { should have_title('Sign in') }
        it { should have_selector('div.alert.alert-error') }
      end

      describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          fill_in "Email",    with: user.email.upcase
          fill_in "Password", with: user.password
          click_button "Sign in"
        end
        it { should have_link('Signout')}
      end
    end #signin
  end #signin page
end
