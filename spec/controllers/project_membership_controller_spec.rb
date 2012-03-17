require 'spec_helper'

describe ProjectMembershipsController do

  describe "GET new" do

    before(:each)    do
      get :new, project_id: @project.id
    end

    it "should be successful" do
      assigns(:button_name).should == "Invite"
    end

    it "should render 'new'" do
      response.should render_template 'new'
    end
  end

  describe "POST 'create'" do

    before(:each) do
      User.stub!(:find_by_email).and_return(@user)
      @member=@user
      @member.stub!(:member?).and_return(false)
      @member.stub!(:join!).with(@project)
      get :create, project_id: @project.id
    end

    it "should have success message" do
      flash[:success].should == "User was invited"
    end

    it "should redirect to members list" do
     response.should redirect_to  project_path(@project)+'/members'
    end
  end

  end