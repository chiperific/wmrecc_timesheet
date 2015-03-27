require 'spec_helper'
require 'support/utilities'

RSpec.describe "Categories Pages" do
  subject { page }
  #let!(:user) { create(:user) }
  user = FactoryGirl.build(:user)

  before { sign_in(user) }

  describe "Index" do
    before { visit categories_path }
    

    it { should have_link('Add New')}

  end

  describe "New" do
    before { visit new_category_path }

    it "should have certain content" do
      should have_content('Add Category')
      should have_button('Submit')
      should have_link('Cancel')
    end

    describe "when submitting" do
      before { visit new_category_path }

      describe "with invalid info" do
        before { visit new_category_path }

        it "should not create category" do
          expect { click_button "submit"}.not_to change(Category, :count)
        end
      end

    end #when submitting
  end #New

  describe "Edit" do
    category = FactoryGirl.build(:category)
    before do
      visit edit_category_path(category)
    end

    it { should have_button('Submit') }
    it { should have_link('Cancel')}
  end

end
