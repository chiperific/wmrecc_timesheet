require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "New User page" do
    before { visit new_user_path }

    it { should have_content('Add new user')}
    it { should have_button('Add user')}
    it { should have_link('Cancel')}
  end

  describe "User index page" do
    before { visit users_path }

    it { should have_content('Current users')}
    it { should have_link('Add new user')}
  end
  
end
