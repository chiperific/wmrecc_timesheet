require 'spec_helper'

describe "Categories Pages" do
  subject { page }

  describe "Index" do
    before { visit categories_path }

    it { should have_content('Current Categories')}
    it { should have_link('Add New')}
  end

  describe "New" do
    before { visit new_category_path }

    it { should have_content('Add Category')}
    it { should have_button('Submit')}
    it { should have_link('Cancel')}

    describe "when submitting" do
      before { visit new_category_path }

      describe "with invalid info" do
        before { visit new_category_path }

        it "should not create category" do
          expect { click_button "Submit"}.not_to change(Category, :count)
        end
      end

    end #when submitting
  end #New

  describe "Edit" do
    let(:category) { FactoryGirl.create(:category)}
    before do
      visit edit_category_path(category)
    end

    it { should have_button('Submit')}
    it { should have_link('Cancel')}
  end

end
