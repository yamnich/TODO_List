require "spec_helper"

describe User do

  it {should have_many(:projects).through(:project_memberships)}
  it {should have_many(:project_memberships)}
  it {should have_many  :lists}
  it {should have_many :tasks}
  it {should validate_presence_of :name}
  it {should validate_presence_of :email}
  it {should validate_presence_of :password}
  it {should ensure_length_of(:password).is_at_least(6).is_at_most(40)}
  it {should ensure_length_of(:name).is_at_most(50)}

  # it {should validate_format_of(:email).with(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)}

  it "should create user with valid attributes" do
    lambda{
      Factory.create(:user)
    }.should change{User.count}.by(1)
  end

  it "should not accept two identical emails in different case" do
    attr = Factory.attributes_for(:user)
    Factory.create(:user, :email => attr[:email].upcase)
    user_with_the_same_email = Factory.build(:user, :email => attr[:email].downcase)
    user_with_the_same_email.should_not be_valid
  end

  describe "password encryption" do

    before(:each) do
      @user = Factory.create(:user)
      @attr = Factory.attributes_for(:user)
    end
    #??????????
   it { should validate_uniqueness_of(:email) }

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    it "should be true if the passwords match" do
      @user.has_password?(@attr[:password]).should be_true
    end

    it "should be false if the passwords don't match" do
      @user.has_password?("invalid").should be_false
    end

    it "should return nil on email/password mismatch" do
      wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
      wrong_password_user.should be_nil
    end

    it "should return nil for an email address with no user" do
      nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
      nonexistent_user.should be_nil
    end

    it "should return the user on email/password match" do
      matching_user = User.authenticate(@attr[:email], @attr[:password])
      matching_user.should == @user
    end

  end

end