require 'spec_helper'

describe ProjectsController do

  before(:each) do
    @user = Factory.create(:user)
    sign_in @user

    @project = mock_model(Project, id: 1, name: "Project", save: true)

    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability){ @ability }
    @ability.can :manage, Project
  end

  describe "GET 'new'" do

    before(:each) do
      Project.stub!(:new).and_return(@project)
      get :new
    end

    it "should render 'new'" do
      response.should render_template 'new'
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      Project.stub!(:find).and_return(@project)
      get :edit, id: @project.id
    end

    it "should render 'edit'" do
      response.should render_template 'edit'
    end
  end

  describe "POST create" do
    before(:each) do
      Project.stub!(:new).and_return(@project)
    end

    def do_create
      post :create, project: @project
    end

    describe "should be successful" do
      before(:each) do
        @project.stub!(:save).and_return(true)
      end


      it "should create the project" do
        Project.should_receive(:new).and_return(@project)
        do_create
      end

      it "should save the project" do
        @project.should_receive(:save).and_return(true)
        do_create
      end

      it "should be redirected to members path" do
        do_create
        response.should redirect_to projects_path
      end

      it "should have a successful flash notice" do
        do_create
        flash[:success].should eql 'Project was successfully created'
      end
    end


    describe "failure" do

      before(:each) do
        @project.stub!(:save).and_return(false)
      end

      it "should create the project" do
        Project.should_receive(:new).and_return(@project)
        do_create
      end

      it "should not save the project" do
       @project.should_receive(:save).and_return(false)
       do_create
      end

      it "should re-render to 'new'" do
        do_create
        response.should render_template 'new'
      end

      it "should have a error flash notice" do
        do_create
        flash[:error].should eql "Project wasn't created. Please try again"
      end

    end
  end

  describe "PUT update" do

    before(:each) do
      Project.stub!(:find).and_return(@project)

    end

    def do_update
      put :update, id: @project.id
    end

    describe "success" do
      before(:each) do
        @project.stub!(:update_attributes).and_return(true)
      end

      it "should find project and return object" do
       Project.should_receive(:find).and_return(@project)
        do_update
      end

      it "should update project with attributes" do
        @project.should_receive(:update_attributes).and_return(true)
        do_update
      end
      it "should redirect to projects_path" do
        do_update
        response.should redirect_to projects_path
      end
      it "should have success message" do
        do_update
        flash[:success].should eql 'Project was successfully updated'
      end

    end

    describe "failure" do
      before(:each) do
        @project.stub!(:update_attributes).and_return(false)
      end

      it "should find project and return object" do
        Project.should_receive(:find).with("1").and_return(@project)
        do_update
      end

      it "should update project with attributes" do
        @project.should_receive(:update_attributes).and_return(false)
        do_update
      end

      it "should redirect to projects_path" do
        do_update
        response.should render_template 'edit'
      end

      it "should have error message" do
        do_update
        flash[:error].should eql "Project wasn't updated"
      end
    end
  end

  describe "DELETE" do

    before(:each) do
      @project_for_delete=Factory.create(:project)
      @project_for_delete.stub!(:id).and_return("1")
      Project.stub!(:find).with("1").and_return(@project_for_delete)
    end

    it "should destroy the project" do
      lambda{
        delete :destroy, id: @project_for_delete
      }.should change(Project, :count).by(-1)
    end

  end




end
