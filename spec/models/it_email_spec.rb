require 'spec_helper'

RSpec.describe ItEmail do
  it_email = FactoryGirl.build_stubbed(:it_email)

  subject { it_email }

  it 'has all the fields' do
    should respond_to(:email)
    should respond_to(:app_default_id)
  end

  it { should be_valid }

  describe "when email is not present" do
    before { it_email.email = "" }

    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        it_email.email = invalid_address
        expect(it_email).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        it_email.email = valid_address
        it_email.app_default_id = 1
        expect(it_email).to be_valid
      end
    end
  end

  describe "when app_default_id is not present" do
    before { it_email.app_default_id = nil }
    it { should_not be_valid }
  end
end
