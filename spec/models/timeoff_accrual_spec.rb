require 'spec_helper'

describe TimeoffAccrual do
  let!(:timeoff_accrual) { FactoryGirl.create(:timeoff_accrual)}

  subject { timeoff_accrual }

  it 'has all the field' do
    should respond_to(:type)
    should respond_to(:app_default_id)
  end

  describe 'when type is not present' do
    before { timeoff_accrual.type = ""}
    it { should_not be_valid }
  end

  describe 'when app_default_id is not present' do
    before { timeoff_accrual.app_default_id = nil }
    it { should_not be_valid}
  end

  
end