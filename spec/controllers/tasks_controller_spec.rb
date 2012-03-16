require 'spec_helper'

describe TasksController do
  render_views
=begin
  before(:each) do
    @user=Factory.create(:user)
    test_sign_in(@user)
    @user.stub!(:id).and_return("1")

    @list=mock_model(List,id: "1", save: true)
    @list.stub!(:id).and_return("1")
    List.stub!(:find).with("1").and_return(@list)
    @list.stub!(:project).and_return nil

    @params={"name" => "My task", "description" => "d", "state" => "In work", "priority" => "5", "executor_id" => '1', "list_id" =>'1'}
    @task=mock_model(Task, @params)
    @task.stub!(:list_id=).and_return(@list.id)
    @task.stub(:executor_id=).and_return @user.id
    @task.stub!(:id).and_return("1")
    @list.stub_chain(:tasks, :find).with("1").and_return(@task)
    @list.stub_chain(:tasks, :new).and_return @task

  end
=end
  describe "POST create" do
    def do_create
      post :create, task: @task_params, list_id: @list
    end

    describe "is successful" do

      before(:each) do
        @task.stub!(:save).and_return true
      end

      it "should create the task" do
        @list.tasks.should_receive(:new).with(@task_params).and_return(@task)
        do_create
      end

      it "should save the project" do
        @task.should_receive(:save).and_return(true)
        do_create
      end

      it "should be redirected to index path" do
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
        @list.tasks.should_receive(:new).with(@task_params).and_return(@task)
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
=begin
  describe "should change task state" do
     before(:each) do
       @list=mock_model(List,id: "1", save: true)
       List.stub!(:find).with("1").and_return(@list)
       @list.stub!(:id).and_return("1")
       @params={"name" => "My task", "description" => "d", "state" => "In work", "priority" => "5", "executor_id" => '1', "list_id" =>'1'}
       @task=mock_model(Task, @params)
       @task.stub!(:save).and_return(true)
       @task.stub!(:update_attributes).and_return(true)
       @task.stub!(:list_id=).and_return(@list.id)
       @task.stub!(:state=).and_return('Done')
       @task.stub!(:change_state).and_return('In work')
       @task.stub!(:id).and_return("1")
       @list.stub_chain(:tasks,:find).with('1').and_return(@task)

     end

    it "should change task state to 'In work'" do
      @task.should_receive(:change_state).and_return('In work')
    end
  end
=end
end


