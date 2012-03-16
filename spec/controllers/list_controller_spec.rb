require 'spec_helper'

describe ListsController do
  render_views
=begin
  before(:each) do
    @user=Factory.create(:user)
    test_sign_in(@user)
    @user.stub!(:id).and_return("1")

    @project=mock_model(Project,id: "1", save: true)
    Project.stub!(:find).with("1").and_return(@project)
    @project.stub!(:id).and_return("1")

    @params={"name" => "My list", "description" => "dr"}
    @list=mock_model(List,@params)
    List.stub!(:new).and_return(@list)
    @list.stub!(:user_id=).and_return(@user.id)
    @list.stub!(:project_id=).and_return(@project.id)
    @list.stub!(:id).and_return("1")
    List.stub!(:find).with("1").and_return(@list)
  end
=end
  def do_create
    post :create, list: @list_params
  end

  def do_create_in_project
    post :create, list: @list_params, project_id: @project.id
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      assigns(:title).should == "New List"
      response.should render_template 'new'
    end
  end


    describe "POST create" do
    before(:each) do
      @list.stub!(:save).and_return(true)
    end
    describe "is successful" do
      describe "just list" do

        it "should create the list" do
          List.should_receive(:new).with(@list_params).and_return(@list)
          do_create
        end

        it "should be redirected to index path" do
          do_create
          response.should redirect_to lists_path
        end

        it "should have a successful flash notice" do
          do_create
          flash[:success].should eql 'List was successfully created'
        end

        it "should save the list" do
          @list.should_receive(:save).and_return(true)
          do_create
        end
      end

     describe "list in the project"  do

       it "should create the list in the project" do
          List.should_receive(:new).with(@list_params).and_return(@list)
          do_create_in_project
       end

       it "should save the list in the project" do
          @list.should_receive(:save).and_return(true)
          do_create_in_project
       end

       it "should have a successful flash notice on project_lists_path" do
         do_create_in_project
         flash[:success].should eql 'List was successfully created'
       end

       it "should be redirected to index path (in project)" do
         do_create_in_project
         response.should redirect_to project_lists_path(@project)
       end
    end

    end
    describe "failure" do
      before(:each) do
        @list.stub!(:save).and_return(false)
      end
      describe "just list" do

        it "should create the list" do
          List.should_receive(:new).with(@list_params).and_return(@list)
          do_create
        end

        it "should save the list" do
          @list.should_receive(:save).and_return(false)
          do_create
        end

        it "should re-render new" do
          do_create
          response.should render_template 'new'
        end

        it "should have a error flash message" do
          do_create
          flash[:error].should eql "List wasn't create successfully created"
        end
      end

       describe "list in the project"  do

        it "should create the list in the project" do

          List.should_receive(:new).with(@list_params).and_return(@list)
          do_create_in_project
        end

        it "should save the list in the project" do
          @list.should_receive(:save).and_return(false)
          do_create_in_project
        end

        it "should have a successful flash notice on project_lists_path" do
          do_create_in_project
          flash[:error].should eql "List wasn't create successfully created"
        end

        it "should re-render template 'new'" do
          do_create_in_project
          response.should render_template 'new'
        end
      end

  end

  end

  describe "PUT update"   do
    before(:each) do
      @list.stub!(:update_attributes).and_return(true)
    end
    describe "success" do

      def do_update
        put :update, {id: @list.id, list: {"name" => "MYList", "description"=>"DR"}}
      end

      def do_update_in_project
        put :update, id: @list.id, list: {"name" => "MYList", "description"=>"DR"}, project_id: @project.id
      end


      it "should find list and return object" do
        List.should_receive(:find).with("1").and_return(@list)
        do_update
      end

      it "should update list with attributes" do
        @list.should_receive(:update_attributes).with("name"=>"MYList", "description" => "DR").and_return(true)
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
        flash[:error].should eql "List wasn't update successfully updated"
      end

      it "should redirect to project_list_path" do
        do_update_in_project
        response.should render_template 'edit'
      end

      it "should have error message project_list_path" do
        do_update_in_project
        flash[:error].should eql "List wasn't update successfully updated"
      end
    end

  end
=begin
  describe "DELETE" do
    describe "for authorized user" do
      it "should destroy the project" do
        @list1=Factory.create(:list)
        lambda{
          delete :destroy, id: @list1
        }.should change(List, :count).by(-1)
      end
    end
  end
=end
end
