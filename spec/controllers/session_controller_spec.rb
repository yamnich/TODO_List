require 'spec_helper'

describe SessionsController do

  before(:each) do
    User.stub!(:authenticate).and_return @user
    do_create_session
  end

  def do_create_session
    post :create, session: {email: @user.email, password: @user.password}
  end

  it "should create current_user with valid data" do
    assigns(:current_user).should == @user
  end

  it "should destroy current_user" do
    get :destroy
    assigns(:current_user).should == nil
  end

  before(:each)   do
  User.stub!(:authenticate).and_return nil
  do_create_session

  end
  it "should put error with invalid data" do
    flash.now[:error].should == 'Invalid email/password combination'
  end

  it "should render template 'invite'" do
    response.should render_template(:invite)
  end

end