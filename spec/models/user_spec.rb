require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  subject { user }

  it 'has all the fields' do
    should respond_to(:fname)
    should respond_to(:lname)
    should respond_to(:active)
    should respond_to(:department_id)
    should respond_to(:supervisor_id)
    should respond_to(:email)
    should respond_to(:password_digest)
    should respond_to(:password)
    should respond_to(:password_confirmation)
    should respond_to(:created_at)
    should respond_to(:updated_at)
    should respond_to(:remember_token)
    should respond_to(:authenticate)
    should respond_to(:annual_time_off)
    should respond_to(:standard_hours)
    should respond_to(:salary_rate)
    should respond_to(:hourly_rate)
    should respond_to(:pay_type)
  end

  it { should be_valid }

  describe "when fname is not present" do
    before { user.fname = " " }
    it { should_not be_valid }
  end

  describe "when lname is not present" do
    before { user.lname = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { user.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    let(:user) { FactoryGirl.create(:user) }
    let(:user_dup) {User.new(fname: "Duplicate", lname: "User", email: "chip@kragt.com", password: "foobar", password_confirmation: "foobar")}
    before do
      user.save
      user_dup.save
    end
    subject {user_dup}
    it { should_not be_valid }
  end

  describe "when password is not present" do
    let(:user) {User.new(fname: "Example", lname: "User", email: "user@example.com", password: "", password_confirmation: "")}
    it { should_not be_valid }
  end

  describe "when password_confirmation != password" do
    before { user.password_confirmation = "not_foobar"}
    
    it { should_not be_valid }
  end

  pending "with a password that's too short" do
    #the let(:user) passes @user.already_has_password? since the short password becomes a password_digest
    let(:user) {User.new(fname: "Short", lname: "Password", email: "short@password.com", password: "aaaa", password_confirmation: "aaaa")}
    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      user.email = mixed_case_email
      user.save
      expect(user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "return value of authenticate method" do
    before { user.save }
    let(:found_user) { User.find_by(email: user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end

    describe "remember token" do
      before { user.save }
      its(:remember_token) { should_not be_blank }
    end
  end #return val of auth method
end


