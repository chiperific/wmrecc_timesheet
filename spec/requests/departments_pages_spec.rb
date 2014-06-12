require 'spec_helper'

describe "Departments Pages" do
  subject { page }

  describe "New" do
    before { visit new_department_path }

    it { should have_content('Add new department')}
    pending { should have_button('Add department')}
    it { should have_link('Cancel')}
  end

  describe "Index" do
    before { visit departments_path }

    it { should have_content('Current departments')}
    it { should have_link('Add new department')}
  end
  
end
