module RSpecControllerStubsMocks
  extend ActiveSupport::Concern
  included do
    before do

      #@user=Factory.create(:user)
      User.stub!(:current_user).and_return(@user=Factory.create(:user))
      #@user.stub!(sign_in).and_return(@user)
      sign_in @user
      @user.stub!(:id).and_return("1")

      @project_params={"name" => "My project","description"=>"mp"}
      @project=mock_model(Project, @project_params)
      @project.stub!(:user_id=).and_return(@user.id)
      @project.stub_chain(:members, :include?).and_return(true)


      @project.stub!(:id).and_return("1")
      Project.stub!(:find).with("1").and_return(@project)
      Project.stub!(:where).and_return(@project)

      @list_params={"name" => "My list", "description" => "dr"}
      @list=mock_model(List,@list_params)
      List.stub!(:new).and_return(@list)
      @list.stub!(:user_id=).and_return(@user.id)
      @list.stub!(:project_id=).and_return(@project.id)
      @list.stub!(:id).and_return("1")
      List.stub!(:find).with("1").and_return(@list)

      @user.stub_chain(:lists,:new).and_return(@list)
      @user.stub_chain(:lists, :all).and_return(@lists)

      @task_params={"name" => "My task", "description" => "d", "state" => "In work", "priority" => "5", "executor_id" => '1', "list_id" =>'1'}
      @task=mock_model(Task, @task_params)
      @task.stub!(:list_id=).and_return(@list.id)
      @task.stub(:executor_id=).and_return @user.id
      @task.stub!(:id).and_return("1")
      @list.stub_chain(:tasks, :find).with("1").and_return(@task)
      @list.stub_chain(:tasks, :new).and_return(@task)

    end
  end
end
