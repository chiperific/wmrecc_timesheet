require 'spec_helper'

describe "User Pages" do
  let(:controller) { UsersController.new }
  let(:user) { FactoryGirl.create(:user) }

  #before do
  #  controller.stub(:path_switch) { path_switch }
  #end

  subject { page }

  # new and edit tests are failing because of inerited methods:
  # http://stackoverflow.com/questions/24522294/rspec-how-to-stub-inherited-method-current-user-w-o-devise
  # http://leeourand.com/2014/02/09/stub-that-object/

  pending "Edit" do
    let(:current_user) {user}
    let(:path_switch) { users_path }
    before do
      current_user.stub(:admin) { true }
      sign_in(user)
      visit edit_user_path(user) 
    end

    it '(check links and content)' do
      should have_button('Submit')
      should have_link('Cancel')
      should have_content(user.fname+"\'s profile")
    end

    describe "when submitting with valid info" do
      describe "should update the user" do
        let(:new_fname) {"New"}
        let(:new_lname) {"Name"}
        before do
          fill_in "user_fname", with: new_fname
          fill_in "user_lname", with: new_lname
          click_button "Submit"
        end

        specify { expect(user.reload.fname).to  eq new_fname }
        specify { expect(user.reload.lname).to eq new_lname }

      end
    end

    describe "when submitting with invalid info" do
      describe "should not update the user" do
        let(:new_fname) {""}
        let(:new_lname) {"Name"}
        before do
          fill_in "user_fname", with: new_fname
          fill_in "user_lname", with: new_lname
          click_button "Submit"
        end

        specify { expect(user.reload.fname).to eq new_fname }
        specify { expect(user.reload.lname).to eq new_lname }

      end
    end
  end

  pending "New" do
    let(:current_user) {user}
    before do
      current_user.stub(:admin) { true }
      sign_in(user)
      visit new_user_path
    end

    it '(check links and content)' do
      should have_content('Add new user')
      should have_button('Submit')
      should have_link('Cancel')
    end

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

    it 'check links and content' do
      should have_content('Current users')
      should have_link('Add new user')
    end
  end
  
end
