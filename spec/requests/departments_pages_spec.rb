require 'spec_helper'

describe "Departments Pages" do
  subject { page }

  describe "New" do
    before { visit new_department_path }

    it { should have_content('Add new department')}
    it { should have_button('Add department')}
    it { should have_link('Cancel')}
  end

  describe "Edit" do
    let(:department) { FactoryGirl.create(:department)}
    before { visit edit_department_path(department)}

    it { should have_button('Submit')}
    it { should have_link('Cancel')}

    describe "when submitting with valid info" do
      describe "should update the department" do
        let(:new_name) {"New Name"}
        before do
          fill_in "department_name", with: new_name
          click_button "Submit"
        end

        specify { expect(department.reload.name).to eq new_name }
      end
    end
  end

  describe "Index" do
    before { visit departments_path }

    it { should have_content('Departments')}
    it { should have_link('Add new department')}
  end
  
end
