require 'spec_helper'

describe ListsController do

  before(:each) do
    @user = Factory.create(:user)
    sign_in @user

    @list = mock_model(List, id: 1, name: "List",save: true)
    mock("My obj")
    List.stub!(:find).and_return(@list)
    @list.stub(:id).and_return("1")

    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability){ @ability }

    @ability.can :manage, List
    @ability.can :manage, Project

  end

  describe "GET 'new'" do

    before(:each) do
      List.stub!(:new).and_return(@list)
      get :new
    end


    it "should render 'new'" do
      response.should render_template 'new'
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      get :edit, id: @list.id
    end

    it "should render 'edit'" do
     response.should render_template 'edit'
    end
  end

  describe "GET index" do

    it "should have lists " do
      @lists= [@list ,@list]
      controller.stub_chain(:current_user, :lists, :where).and_return(@lists)
      get :index
      assigns(:lists).should == @lists
    end

    it "should have lists inside the project" do
      @project = mock_model(Project, id: 1, name: "Project")
      @project.stub!(:id).and_return("1")
      Project.stub!(:find).and_return(@project)
      @project.stub!(:lists).and_return(@lists)
      @list.stub!(:project_id).and_return(@project.id)
      get :index, project_id: @project.id
      assigns(:lists).should == @lists
    end
  end

  describe "POST create" do
    before(:each) do

    end

    def do_create
      post :create, list: {"name" => "List", "description" => "My List"}
    end

    def do_create_in_project
      post :create, list: {"name" => "List", "description" => "My List"}, project_id: @project.id
    end


    describe "success" do
        before(:each) do
          List.stub!(:new) .and_return(@list)
        end

        it "should create the list" do
          List.should_receive(:new).and_return(@list)
          do_create
        end

        it "should be redirected to members path" do
          do_create
          response.should redirect_to lists_path
        end

        it "should have a successful flash notice" do
          do_create
          flash[:success].should eql 'List was successfully created'
        end

        it "should save the list" do
          @list.stub!(:save).and_return(true)
          @list.should_receive(:save).and_return(true)
          do_create
        end


       before(:each) do
         @project = mock_model(Project, id: 1, name: "Project")
         @project.stub!(:id).and_return("1")
         Project.stub!(:find).and_return(@project)
        @project.stub_chain(:lists, :new).and_return(@list)

        end

       it "should create the list in the project" do
         list_association=mock("list_association")
         @project.should_receive(:lists).and_return(list_association)
         list_association.should_receive(:new).and_return(@list)
        do_create_in_project
       end

       it "should save the list in the project" do
          @list.stub!(:save).and_return(true)
          @list.should_receive(:save).and_return(true)
          do_create_in_project
       end

       it "should have a successful flash notice on project_lists_path" do
         do_create_in_project
         flash[:success].should eql 'List was successfully created'
       end

       it "should be redirected to members path (in project)" do
         do_create_in_project
         response.should redirect_to project_lists_path(@project)
       end
     end

    describe "failure" do
        before(:each) do
          List.stub!(:new).and_return(@list)
          @list.stub!(:save).and_return(false)
        end

        it "shouldn't create the list" do
          List.should_receive(:new).and_return(@list)
          do_create
        end

        it "shouldn't save the list" do
          @list.should_receive(:save).and_return(false)
          do_create
        end

        it "should re-render new" do
          do_create
          response.should render_template 'new'
        end

        it "should have a error flash message" do
          do_create
          flash[:error].should eql "List wasn't successfully created"
        end


        before(:each) do
          @project = mock_model(Project, id: 1, name: "Project")
          @project.stub!(:id).and_return("1")
          Project.stub!(:find).and_return(@project)
          @project.stub_chain(:lists, :new).and_return(@list)

        end

        it "shouldn't create the list in the project" do

         # @user.lists.should_receive(:new).and_return(@list)
          #do_create_in_project
        end

        it "should save the list in the project" do
          @list.stub!(:save).and_return(false)
          @list.should_receive(:save).and_return(false)
          do_create_in_project
        end

        it "should have a successful flash notice on project_lists_path" do
          do_create_in_project
          flash[:error].should eql "List wasn't successfully created"
        end

        it "should re-render template 'new'" do
          do_create_in_project
          response.should render_template 'new'
        end
  end

    describe "PUT update"   do
      before(:each) do
        @list.stub!(:update_attributes).and_return(true)
        List.stub!(:find).and_return(@list)
        @list.stub!(:id).and_return("1")
      end

      def do_update
        put :update, id: @list.id, list: {"name" => "My list", "description" => "dr"}
      end

      def do_update_in_project
        put :update, id: @list.id, list: {"name" => "My list", "description" => "dr"}, project_id: @project.id
      end

      describe "success" do

        it "should find list and return object" do
          do_update
        end

        it "should update list with attributes" do
          @list.should_receive(:update_attributes).and_return(true)
          do_update
        end
        it "should redirect to lists_path" do
          do_update
          response.should redirect_to lists_path
        end
        it "should have success message" do
          do_update
          flash[:success].should eql 'List was successfully updated'
        end
      end
      before(:each) do
        @project = mock_model(Project, id: 1, name: "Project")
        @project.stub!(:id).and_return("1")
        Project.stub!(:find).and_return(@project)
        @project.stub_chain(:lists,:find).and_return(@list)
        @list.stub!(:id).and_return("1")
        @list.stub!(:update_attributes).and_return(true)

      end

      it "should redirect to project_lists_path" do
        do_update_in_project
        response.should redirect_to project_lists_path(@project)
      end

      it "should have success message on projects_list_path" do
        do_update_in_project
        flash[:success].should eql 'List was successfully updated'
      end
    end

    describe "failure" do
      before(:each) do
        @list.stub!(:update_attributes).and_return(false)
      end

      def do_update
        put :update, id: @list.id
      end

      def do_update_in_project
        put :update, id: @list.id, project_id: @project.id
      end

      it "should find project and return object" do
        List.should_receive(:find).with("1").and_return(@list)
        do_update
      end

      it "should update project with attributes" do
        @list.should_receive(:update_attributes).and_return(false)
        do_update
      end

      it "should redirect to projects_path" do
        do_update
        response.should render_template 'edit'
      end

      it "should have error message" do
        do_update
        flash[:error].should eql "List wasn't successfully updated"
      end

      before(:each) do
        @project = mock_model(Project, id: 1, name: "Project")
        @project.stub!(:id).and_return("1")
        Project.stub!(:find).and_return(@project)
        @project.stub_chain(:lists,:find).and_return(@list)
        @list.stub!(:id).and_return("1")
        @list.stub!(:update_attributes).and_return(false)

      end

      it "should redirect to project_list_path" do
        do_update_in_project
        response.should render_template 'edit'
      end

      it "should have error message project_list_path" do
        do_update_in_project
        flash[:error].should eql "List wasn't successfully updated"
      end
    end

end

  describe "DELETE" do

    before(:each) do
      @list.stub!(:id).and_return("1")
      List.stub!(:find).with("1").and_return(@list)

      @list.stub!(:destroy).and_return(true)
    end
    it "should destroy the list" do
      @list.should_receive(:destroy).and_return(true)
      delete :destroy, id: @list.id

      end
    end
end
