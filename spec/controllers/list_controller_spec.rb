require 'spec_helper'

describe ListsController do
  render_views

  def do_create
    post :create, list: @list_params
  end

  def do_create_in_project
    post :create, list: @list_params, project_id: @project.id
  end

  describe "GET 'invite'" do
    it "should be successful" do
      get :invite
      assigns(:title).should == "New List"
    end

    it "should render 'invite'" do
      get :invite
      response.should render_template 'invite'
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get :edit, id: @list.id
      assigns(:title).should == "Edit List"
    end
    it "should render 'invite'" do
      get :edit, id: @list.id
      response.should render_template 'edit'
    end
  end

  describe "GET members" do

    it "should have right title" do
      get :members
      assigns(:title).should == "Index List"
    end
    before(:each) do
      @lists= [@list ,@list]
    end

    it "should have lists inside the project" do
      @list.stub!(:project_id).and_return(nil)
      @user.stub_chain(:lists,:all).and_return(@lists)
      get :members
      assigns(:lists).should == @lists
    end

    it "should have lists inside the project" do
      @project.stub_chain(:lists,:all).and_return(@lists)
      @list.stub!(:project_id).and_return(@project.id)
      get :members, project_id: @project.id
      assigns(:lists).should == @lists
    end
  end

    describe "POST create" do
    before(:each) do
      @list.stub!(:save).and_return(true)
    end
    describe "is successful" do
      describe "just list" do

        it "should create the list" do
          List.should_receive(:invite).with(@list_params).and_return(@list)
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
          @list.should_receive(:save).and_return(true)
          do_create
        end
      end

     describe "list in the project"  do

       it "should create the list in the project" do
          List.should_receive(:invite).with(@list_params).and_return(@list)
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

       it "should be redirected to members path (in project)" do
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
          List.should_receive(:invite).with(@list_params).and_return(@list)
          do_create
        end

        it "should save the list" do
          @list.should_receive(:save).and_return(false)
          do_create
        end

        it "should re-render invite" do
          do_create
          response.should render_template 'invite'
        end

        it "should have a error flash message" do
          do_create
          flash[:error].should eql "List wasn't create successfully created"
        end
      end

       describe "list in the project"  do

        it "should create the list in the project" do

          List.should_receive(:invite).with(@list_params).and_return(@list)
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

        it "should re-render template 'invite'" do
          do_create_in_project
          response.should render_template 'invite'
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
    it "should destroy the project" do
      # @project.stub!(:id).and_return(nil)
      # @project.stub!(:find).with(@project.id).and_return(@project)
        @list_for_delete=Factory.create(:list) #, project_id: @project)
        @list_for_delete.stub!(:id).and_return("1")
        List.stub!(:find).with("1").and_return(@list_for_delete)

        lambda{
         delete :destroy, id: @list_for_delete
       }.should change(List, :count).by(-1)
      end
    end
=end
end
