require 'spec_helper'
require 'support/utilities'

describe "Request Pages" do
  let(:user) { FactoryGirl.create(:user) }
  let(:request) { FactoryGirl.create(:request)}

  subject { page }

  describe "New" do
    before { visit new_user_request_path(user) }

    it "has content" do
      should have_content("Submit time off request")
      should have_button("Submit")
    end

    describe "when submitting" do
      describe "with missing info" do
        before do
          find(:xpath, "//input[@id='request_date']").set ""
          fill_in "request_hours", with: ""
        end
        
        it "should raise a validation error" do
          expect { click_button "Submit" }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Hours can't be blank, Hours is not a number, Date can't be blank")
        end
      end

      describe "with valid info" do
        before do
          find(:xpath, "//input[@id='request_date']").set "2001/09/11"
          fill_in "request_hours", with: "8"
        end
        it "should save the record" do
          expect do
            click_button "Submit" 
          end.to change(Request, :count)
        end
      end
    end
  end #New

  describe "Index" do
    before { visit user_requests_path(user)}

    it { should have_content("Timekeeper") }

  end

  pending "Edit" do
    before { visit edit_user_request_path(user, request) }

    it { should have_content("Edit time off request")}
    it { should have_button("Submit")}

    describe "when submitting" do
      describe "with invalid info" do
        let(:invalid_hours) {"0"}
        before do 
          fill_in "request_hours", with: invalid_hours
          click_button "Submit"
        end
        specify { expect(request.reload.hours).not_to eq invalid_hours }
      end

      describe "with missing info" do
        let(:invalid_date) {""}
        before do 
          fill_in "request_date", with: invalid_date
          click_button "Submit"
        end
        specify { expect(request.reload.date).not_to eq invalid_date }
      end

      describe "with valid info" do
        let(:valid_date) {"1990/01/01"}
        before do
          visit new_user_request_path(user)
          fill_in "fake_date",     with: valid_date
          fill_in "request_date",  with: valid_date
          click_button "Submit"
        end
        specify { expect(request.reload.date).to eq valid_date }
      end
    end
  end
end