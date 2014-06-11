require 'spec_helper'

describe "CategoriesPages" do
  subject { page }

  describe "Index" do
    before { visit categories_path }

    it { should have_content('Current Categories')}
    it { should have_button('Add new category')}
  end

  describe "New" do
    before { visit new_category_path }

    it { should have_content('Add new category')}
    it { should have_link('Cancel')}
  end

end
