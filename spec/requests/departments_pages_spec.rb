require 'spec_helper'

describe "Departments Pages" do
  subject { page }
  let!(:user) { FactoryGirl.create(:user) }
  before { sign_in(user) }

  describe "New" do
    before { visit new_department_path }

    it { should have_content('Add new department')}
    it { should have_button('Submit')}
    it { should have_link('Cancel')}

    describe "when submitting" do
      describe "with invalid info" do
        before { visit new_department_path }

        it "should not add a department" do
          expect { click_button "Submit"}.not_to change(Department, :count)
        end
      end

      describe "with valid info" do
        before do 
          visit new_department_path
          fill_in "department[name]", with: "new dept"
          select "Active",                from: "department[active]"
        end

        it "should add a new department" do
          expect { click_button "Submit" }.to change(Department, :count).by(1)
        end
      end
    end #when submitting
  end #New

  describe "Edit" do
    let(:department) { FactoryGirl.create(:department)}
    before { visit edit_department_path(department)}

    it { should have_button('Submit')}
    it { should have_link('Cancel')}

    describe "when submitting with valid info" do
      describe "should update the department" do
        let(:new_name) {"New Name"}
        before do
          fill_in "department[name]", with: new_name
          click_button "Submit"
        end

        specify { expect(department.reload.name).to eq new_name }
      end
    end
  end

  describe "Index" do
    before { visit departments_path }

    it { should have_content('Departments')}
    it { should have_link('Add New')}
  end
  
end
