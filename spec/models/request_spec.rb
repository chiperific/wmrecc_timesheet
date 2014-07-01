require 'spec_helper'

describe Request do
  before { @request = Request.new(
    user_id: 2,
    date: "2014/01/01",
    hours: 8) }

  subject { @request }

  it { should respond_to(:id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:date) }
  it { should respond_to(:hours) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:sv_approval) }
  it { should respond_to(:sv_reviewed) }

  it { should be_valid }

  describe "when hours is not present" do
    before { @request.hours = nil}
    it { should_not be_valid }
  end

  describe "when hours is zero" do
    before { @request.hours = 0}
    it { should_not be_valid }
  end

  describe "when date is not present" do
    before { @request.date = nil }
    it { should_not be_valid }
  end

  describe "when user_id is not present" do
    before { @request.user_id = nil }
    it { should_not be_valid }
  end
end
