require 'spec_helper'

describe TasksController do
#  render_views
  before(:each) do
    @list.stub!(:project).and_return nil
  end
  describe "GET invite" do
    it "should be successful" do
      get :invite,  list_id: @list
      assigns(:title).should == "New Task"
    end

    it "should render 'invite'" do
      get :invite,  list_id: @list
      response.should render_template 'invite'
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get :edit, id: @task.id, list_id: @list.id
      assigns(:title).should == "Edit task"
    end
    it "should render 'invite'" do
      get :edit, id: @task.id, list_id: @list
      response.should render_template 'edit'
    end
  end

  describe "GET 'members'" do
    before(:each) do
      @task.stub!(:state).and_return('done')
      @tasks = [@task, @task]
      @task.stub!(:state).and_return('in_work')
      @tasks_in_work = [@task, @task]
      @list.stub!(:tasks).and_return(@tasks)
      @list.stub!(:tasks, :where).and_return(@tasks)
      get :members, list_id: @list.id
    end

    it "should have right title" do
      assigns(:title).should == "Index task"
    end

    it "should get all  tasks" do
      assigns(:tasks).should == @tasks
    end

    it "should get done tasks" do
      assigns(:tasks).should == @tasks
    end

    it "should get in work tasks" do
      assigns(:tasks).should == @tasks_in_work
    end
  end

  describe "POST create" do
    def do_create
      post :create, task: @task_params, list_id: @list
    end

    describe "is successful" do

      before(:each) do
        @task.stub!(:save).and_return true
      end

      it "should create the task" do
        @list.tasks.should_receive(:invite).with(@task_params).and_return(@task)
        do_create
      end

      it "should save the project" do
        @task.should_receive(:save).and_return(true)
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
        @list.tasks.should_receive(:invite).with(@task_params).and_return(@task)
        do_create
      end

      it "should save the project" do
        @task.should_receive(:save).and_return(false)
        do_create
      end

      it "should re-render 'invite'" do
        do_create
        response.should render_template('invite')
      end
      it "should have a error flash notice" do
        do_create
        flash[:error].should eql "Task wasn't successfully created"
      end
    end

  end

  describe "PUT update" do
    def do_update
      put :update, id: @task.id, list_id: @list.id
    end
    describe "is successful" do

      before(:each) do
        @task.stub!(:update_attributes).and_return(true)

      end

      it "should find task and return object" do
        @list.tasks.should_receive(:find).with("1").and_return(@task)
        do_update
      end

      it "should update task with attributes" do
        @task.should_receive(:update_attributes).and_return(true)
        do_update
      end

      it "should redirect to list_tasks_path" do
        do_update
        response.should redirect_to list_tasks_path(@list)
      end

      it "should have success message" do
        do_update
        flash[:success].should eql  "Task is updated"
      end
    end

    describe "failure" do
      before(:each) do
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
        flash[:error].should eql  "Task is not updated"
      end
    end
  end

  describe "DELETE" do
    before(:each) do
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

    end

  describe "should change task state" do
    before(:each) do
      @task.stub!(:state=).and_return('In work')
      @task.stub!(:state).and_return('Done')
    end

    it "should change task state" do
      @task.stub!(:update_attributes).and_return(true)
      get :change_state, id: @task, list_id: @list.id
      flash[:success].should == "State was changed successfully"
    end

    it "should not change task state" do
      @task.stub!(:update_attributes).and_return(false)
      get :change_state, id: @task, list_id: @list.id
      flash[:error].should ==  "State was not changed"
    end
  end

end


