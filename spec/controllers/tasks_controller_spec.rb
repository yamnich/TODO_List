require 'spec_helper'

describe TasksController do
  before(:each) do
    @user = Factory.create(:user)
    sign_in @user

    @project = mock_model(Project, id: 1, name: "Project")
    @project.stub!(:id).and_return("1")
    Project.stub!(:find).and_return(@project)

    @list = mock_model(List, id: 1, name: "List",save: true)
    List.stub!(:find).and_return(@list)
    @list.stub(:id).and_return("1")

    @task = mock_model(Task, id: 1, name: "Task",save: true)

    @list.stub_chain(:tasks, :new).and_return(@task)
    @list.stub_chain(:tasks, :find).and_return(@task)

    @task.stub(:id).and_return("1")

    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability){ @ability }

  end

  describe "GET 'new'" do

    before(:each) do
      @project.stub!(:members).and_return(@user)
      @list.stub!(:project).and_return(@project)
    end
    describe "success" do
      it "should render 'new'" do
        @ability.can :read, List
        @ability.can :manage, Task
        get :new,  list_id: @list
        response.should render_template 'new'
      end
    end
    describe "failure" do
      it "should redirect to home page" do
        @ability.cannot :read, List
        @ability.cannot :manage, Task
        get :new,  list_id: @list
        response.should redirect_to root_path
      end
    end
  end

  describe "GET 'edit'" do
    describe "success" do
      it "should render 'edit'" do
        @ability.can :read, List
        @ability.can :manage, Task
        get :edit, id: @task.id, list_id: @list
        response.should render_template 'edit'
      end
    end
    describe "failure" do
      it "should render 'edit'" do
        @ability.cannot :read, List
        @ability.cannot :manage, Task
        get :edit, id: @task.id, list_id: @list
        response.should redirect_to root_url
      end
    end
  end

  describe "GET 'index'" do
    describe "failure" do
      it "should redirect to home page" do
        @ability.cannot :read, List
        @ability.cannot :read, Task
        get :index, list_id: @list
        response.should redirect_to root_url
      end
    end

    describe "success" do
      before(:each) do
        @ability.can :read, List
        @ability.can :read, Task
        @tasks = [@task, @task]
      end

      it "should get all  tasks" do
        @list.stub!(:tasks).and_return(@tasks)
        get :index, list_id: @list.id, state: nil
        assigns(:tasks).should == @tasks
      end

      it "should get done tasks" do
        @list.stub_chain(:tasks, :where).and_return(@tasks)
        get :index, list_id: @list.id, state: 'done'
        assigns(:tasks).should == @tasks
      end

      it "should get in work tasks" do
        @list.stub_chain(:tasks, :where).and_return(@tasks)
        get :index, list_id: @list.id, state: 'in_process'
        assigns(:tasks).should == @tasks
      end
    end
  end

  describe "POST create" do
    before(:each) do
      @ability.can :read, List
      @ability.can :manage, Task
      Task.stub!(:new).and_return(@task)
    end

    def do_create
      post :create, task: {"name" => "Task"}, list_id: @list
    end

    describe "success" do

      before(:each) do
        @task.stub!(:save).and_return(true)
        @task.stub!(:send_email_to)
      end

      it "should create the task" do
        @list.tasks.should_receive(:new).and_return(@task)
        do_create
      end

      it "should save the project" do
        @task.should_receive(:save).and_return(true)
        do_create
      end

      it "should send email to executor" do
        @task.should_receive(:send_email_to)
        do_create
      end

      it "should be redirected to members path" do
        do_create
        response.should redirect_to list_tasks_path(@list)
      end

      it "should have a successful flash notice" do
        do_create
        flash[:success].should eql 'Task was successfully created'
      end
    end

    describe "failure" do
      before(:each) do
        @task.stub!(:save).and_return(false)
      end

      it "should create the task" do
        @list.tasks.should_receive(:new).and_return(@task)
        do_create
      end

      it "should save the project" do
        @task.should_receive(:save).and_return(false)
        do_create
      end

      it "should re-render 'new'" do
        do_create
        response.should render_template('new')
      end
      it "should have a error flash notice" do
        do_create
        flash[:error].should eql "Task wasn't created"
      end

      it "should redirect to home path" do
        @ability.cannot :read, List
        @ability.cannot :manage, Task
        do_create
        response.should redirect_to root_path
      end
    end

  end

  describe "PUT update" do
    def do_update
      put :update, id: @task.id, list_id: @list.id
    end

    describe "success" do

      before(:each) do
        @ability.can :read, List
        @ability.can :manage, Task

        @task.stub!(:update_attributes).and_return(true)
        @task.stub!(:send_email_to)
        @task.stub!(:executor)
      end

      it "should find task and return object" do
        @list.tasks.should_receive(:find).with("1").and_return(@task)
        do_update
      end

      it "should update task with attributes" do
        @task.should_receive(:update_attributes).and_return(true)
        do_update
      end

      it "should send the email to task executor" do
        @task.should_receive(:send_email_to).and_return(true)
        do_update
      end

      it "should redirect to list_tasks_path" do
        do_update
        response.should redirect_to list_tasks_path(@list)
      end

      it "should have success message" do
        do_update
        flash[:success].should eql  "Task was successfully updated"
      end
    end

    describe "failure" do
      before(:each) do
        @ability.can :read, List
        @ability.can :manage, Task

        @task.stub!(:update_attributes).and_return(false)
      end

      it "should find task and return object" do
        @list.tasks.should_receive(:find).with("1").and_return(@task)
        do_update
      end

      it "should update task with attributes" do
        @task.should_receive(:update_attributes).and_return(false)
        do_update
      end

      it "should re-render 'edit'" do
        do_update
        response.should render_template 'edit'
      end

      it "should have error message" do
        do_update
        flash[:error].should eql  "Task wasn't updated"
      end

      it "should redirect to home page " do
        @ability.cannot :read, List
        @ability.cannot :manage, Task
        do_update
        response.should redirect_to root_path
      end
    end
  end

  describe "DELETE" do
    before(:each) do
      @ability.can :read, List
      @ability.can :manage, Task
      @task = Factory.create(:task)

      @task.stub!(:id).and_return("1")
      @list.stub_chain(:tasks,:find).with('1').and_return(@task)
    end

    it "should destroy the task" do
      lambda{
        delete :destroy, id: @task, list_id: @list
      }.should change(Task, :count).by(-1)
      response.should  redirect_to list_tasks_path(@list)
    end

    it "should redirect to home page" do
      @ability.cannot :read, List
      @ability.cannot :manage, Task
      delete :destroy, id: @task, list_id: @list
      response.should redirect_to  root_path
    end
  end

  describe "should change task state" do
    before(:each) do
      @ability.can :read, List
      @ability.can :manage, Task

      @task.stub!(:change_state)
    end

    it "should change task state" do
      @task.stub!(:update_attributes).and_return(true)
      get :change_state, id: @task, list_id: @list.id
      flash[:success].should == "State was changed successfully"
    end

    it "should not change task state" do
      @task.stub!(:update_attributes).and_return(false)
      get :change_state, id: @task, list_id: @list.id
      flash[:error].should ==  "State wasn't changed"
    end
  end

end


