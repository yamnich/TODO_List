require 'spec_helper'

describe ProjectMembershipsController do

  before(:each) do
    @user = Factory.create(:user)
    sign_in @user
    @project = mock_model(Project, id: 1, name: "Project", save: true)

    Project.stub!(:find).and_return(@project)
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability){ @ability }
    @ability.can :manage, Project
  end

describe "GET new" do

  before(:each)    do
    get :new, project_id: @project.id
  end

  it "should render 'new'" do
    response.should render_template 'new'
  end
end

describe "POST 'create'" do

  before(:each) do
    Project.stub!(:find).and_return(@project)
    User.stub!(:find_by_email).and_return(@user)
    @user.stub!(:join!).with(@project)
    @project.stub!(:invite_user).with(@user)
  end

  def create
    post :create, project_id: @project.id
  end

  it "should redirect to members list" do
    create
    response.should redirect_to  project_path(@project)+'/members'
  end

  describe "success" do
    before(:each) do
      @user.stub!(:nil?).and_return(false)
      @user.stub!(:member?).and_return(false)
      @user.stub!(:join!).and_return(true)
      @project.stub!(:invite_user).with(@user)
    end

    it "should call join! " do
      @user.should_receive(:join!).and_return(true)
      create
    end

    it "should have success message" do
      create
      flash[:success].should == "User was invited"
    end

    it "should send the invitation mail" do
      @project.should_receive(:invite_user).with(@user)
      create
    end
  end

  describe "failure" do
    before(:each) do
      @user.stub!(:member?).and_return(true)
    end

    it "should have the notice " do
      create
      flash[:notice].should == "User is already invited"
    end

  end
end

describe "GET members" do
  it "should return the project members" do
    Project.stub!(:find).and_return(@project)
    @members = [@user, @user]
    @project.stub!(:members).and_return(@members)
  end
end


describe "DELETE remove member" do
  before(:each) do
    User.stub!(:find).and_return(@user)
    Project.stub!(:find).and_return(@project)
  end
  def remove_user
    delete :destroy, project_id: @project.id, id: @user.id
  end


  describe "success" do
    before(:each) do
      @user.stub!(:leave!).and_return(true)
    end

    it "should have success message" do
      remove_user
      flash[:success].should == "User was deleted from project"
    end

  end
  describe "success" do
    before(:each) do
      @user.stub!(:leave!).and_return(false)
    end

    it "should have success message" do
      remove_user
      flash[:error].should == "User wasn't deleted from project"
    end
  end
end

  end