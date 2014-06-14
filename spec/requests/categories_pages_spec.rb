require 'spec_helper'

describe "Categories Pages" do
  subject { page }

  describe "Index" do
    before { visit categories_path }

    it { should have_content('Current Categories')}
    it { should have_link('Add new category')}
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

      describe "with valid info" do
        before do
          visit new_category_path
          fill_in "category_name",    with: "new cat"
          select "Active",                from: "category[active]"
          select "IT",                from: "category_department_id"
        end

        it "should create a category" do
          expect { click_button "Submit" }.to change(Category, :count).by(1)
        end
      end
    end #when submitting
  end #New

  describe "Edit" do
    let(:category) { FactoryGirl.create(:category)}
    before { visit edit_category_path(category)}

    it { should have_button('Submit')}
    it { should have_link('Cancel')}

    describe "when submitting with valid info" do
      describe "should update the category" do
        let(:new_name) {"New Cat Name"}
        before do
          fill_in "category[name]", with: new_name
          click_button "Submit"
        end

        specify { expect(category.reload.name).to eq new_name }

      end
    end
  end

end
