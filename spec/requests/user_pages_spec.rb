require 'spec_helper'
require 'rails_helper'
require 'support/utilities'

RSpec.describe "User Pages" do

  user = FactoryGirl.create(:user)
  department = FactoryGirl.create(:department)

  before { 
    sign_in(user)
   }

  subject { page }

  describe "Edit" do
    before { visit edit_user_path(user) }
    it '(check links and content)' do
      should have_button('Submit')
      should have_link('Cancel')
      should have_content("Edit your profile")
    end

    describe "when submitting with valid info" do
      describe "should update the user" do
        before do
          fill_in "user_fname", with: "new_fname"
          fill_in "user_lname", with: "new_lname" 
          click_button "submit"
        end

        specify { expect(user.reload.fname).to  eq "new_fname" }
        specify { expect(user.reload.lname).to eq "new_lname" }

      end
    end

    # describe "when submitting with invalid info" do
    #   describe "should not update the user" do
    #     before do
    #       fill_in "user_fname", with: nil
    #       fill_in "user_lname", with: "new_lname"
    #       click_button "submit"
    #     end

    #     specify { expect(user.reload.fname).not_to eq "new_fname" }
    #     specify { expect(user.reload.lname).not_to eq "new_lname" }

    #   end
    # end
   end

  describe "New" do
    before { visit new_user_path }

    it '(check links and content)' do
      should have_content('Add new user')
      should have_button('Submit')
      should have_link('Cancel')
    end

    describe "with invalid info" do
      before {visit new_user_path}

      it "should not create a user" do
        expect {click_button "submit" }.not_to change(User, :count)
      end
    end

    describe "with valid info" do
      before do
        visit new_user_path
        fill_in "user_fname",   with: "noob"
        fill_in "user_lname",   with: "face"
        fill_in "user_email",   with: "user@example.com"
        fill_in "user_password",              with: "foobar"
        fill_in "user_password_confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button "submit" }.to change(User, :count).by(1)
      end
    end
  end

  describe "Index" do
    
    before { visit users_path }

    it 'checks links and content' do
      should have_content('users')
      should have_link('Add new user')
    end
  end
  
end
