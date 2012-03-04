require 'spec_helper'

describe ProjectsController do
  render_views
  describe "POST create" do

    describe "success" do

      before(:each) do
        #User.stub!(:create).and_return(@user=mock_model(User,first_name: "Curr_user",last_name: "CU",password: "111111", salt:"549f167430acde568b4856cc25337ca8d13991641c8ed347c", save: true))
        @user=Factory.create(:user)
        @user.save
        test_sign_in(@user)
        @user.stub!(:id).and_return("1")
        @params={name: "My project",description: "mp",user_id: @user.id.to_s}
                Project.stub!(:new).and_return(@project=mock_model(Project, save: true))
        @project.user_id = @user.id
      end

      def do_create
        post :create, project: @params
      end

      it "should create the project" do
        Project.should_receive(:new).with(@params).and_return(@project)
        do_create
      end

      it "should save the project" do
        @project.should_receive(:save).and_return(true)
        do_create
      end

      it "should be redirected to index path" do
        do_create
        response.should redirect_to projects_path
      end

      it "should have a successful flash notice" do
        do_create
        flash[:success].should eql 'Project was successfully created'
      end

    end
  end

=begin
    ######
      describe "failure" do
        before(:each) do
          Project.stub!(:new).and_return(@project=mock_model(Project,name: "My project",description: "mp",user_id: @user.id ,save: false))
          @user = test_sign_in(Factory(:user))
        end

        def do_create
          post :create, project: {name: "My project", user_id: @user.id}
        end

        it "should create the project" do
          Project.should_receive(:new).with({"name" => "My project"}, {}).and_return(@project)
          do_create
        end

        it "should save the project" do
          @project.should_receive(:save).and_return(false)
          do_create
        end

        it "should re-render to new" do
          do_create
          response.should render_template 'projects/new'
        end

        it "should have a error flash notice" do
          do_create
          flash[:error].should eql "Project wasn't created. Please try again"
        end


      end
  end

  describe "PUT update" do
    describe "success" do
      before(:each) do
        @project = mock_model(Project, update_attributes: true)
        Project.stub!(:find).with("1").and_return(@project)
      end

      it "should find project and return object" do
        Project.should_receive(:find).with("1").and_return(@project)
      end



    end

    describe "failure" do

    end
  end
=end
  end