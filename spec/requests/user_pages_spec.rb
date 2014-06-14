require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "New" do
    before { visit new_user_path }

    it { should have_content('Add new user')}
    it { should have_button('Submit')}
    it { should have_link('Cancel')}

    describe "with invalid info" do
      before {visit new_user_path}

      it "should not create a user" do
        expect {click_button "Submit" }.not_to change(User, :count)
      end
    end

    describe "with valid info" do
      before do
        visit new_user_path
        fill_in "user_fname",   with: "noob"
        fill_in "user_lname",   with: "face"
        fill_in "user_email",   with: "user@example.com"
        select "IT",            from: "user_department_id"
        fill_in "user_password",              with: "foobar"
        fill_in "user_password_confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button "Submit" }.to change(User, :count).by(1)
      end
    end
  end

  describe "Index" do
    before { visit users_path }

    it { should have_content('Current users')}
    it { should have_link('Add new user')}
  end

  describe "Edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user)}

    it { should have_button('Submit')}
    it { should have_link('Cancel')}
    it { should have_content(user.fname+"\'s profile")}
  end
  
end
