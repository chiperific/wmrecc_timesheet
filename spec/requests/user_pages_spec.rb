require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "New" do
    before { visit new_user_path }

    it { should have_content('Add new user')}
    pending { should have_button('Add user')}
    it { should have_link('Cancel')}
  end

  describe "Index" do
    before { visit users_path }

    it { should have_content('Current users')}
    it { should have_link('Add new user')}
  end
  
end
