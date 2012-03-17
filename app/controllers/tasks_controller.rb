class TasksController < ApplicationController
  respond_to :html, :xml, :json
  before_filter :authenticate

  def new
    @title = "New Task"
    @list =  List.find(params[:list_id])
    @project = @list.project
    if !@project.nil?
      @members=@project.members
    end
    @task = @list.tasks.new
    @button_name = "New"
  end

  def create
    @title = 'Creating task'
    @list = List.find(params[:list_id])
    @task = @list.tasks.new(params[:task])
    if @task.save
      flash[:success] = 'Task was successfully created'
      if @task.executor_id != current_user.id
        @user = User.find_by_id(@task.executor_id)
        if @list.project
          @project = @list.project
          UserMailer.assignment(@user, @project.name, @task.name).deliver
        else
          UserMailer.assignment(@user, '', @task.name).deliver
        end
      end
      redirect_to list_tasks_path(@list)
    else
      flash[:error] = "Task wasn't successfully created"
      render 'new'
    end
  end

  def index
     @title = "Index task"
     @list= List.find(params[:list_id])
     if params[:state] == "done"
       @tasks = @list.tasks.where("state = 'Done'")
     elsif params[:state] == "in_work"
       @tasks = @list.tasks.where("state = 'In work'")
     else
       @tasks = @list.tasks
     end
  end

  def edit
    @title = "Edit task"
    @list =List.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    @button_name = "Update"
  end

  def update
    @list =List.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    if @task.update_attributes(params[:task])
      flash[:success] = "Task is updated"
      if !@task.executor_id != current_user.id  && !@project.nil?
        @project = @list.project
        @user = User.find_by_id(@task.executor_id)
        UserMailer.assignment(@user, @project.name, @task.name).deliver
      end
      redirect_to list_tasks_path(@list)
    else
      flash[:error] = "Task is not updated"
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = "Task is destroyed."
    redirect_to list_tasks_path(@task.list)
  end

  def change_state
    current_user.tasks.find(params[:id])
    @task = @list.tasks.find(params[:id])
    if  @task.state == "Done"
      @task.state = "In work"
    else
      @task.state = "Done"
    end
    if @task.update_attributes(params[:task])
      flash[:success] = "State was changed successfully"
      if !@project.nil? and !@task.executor_id.nil != current_user
        @user = User.find_by_id(@task.executor_id)
        UserMailer.changed(@user, @project.name, @task.name).deliver
      end
    else
     flash[:error] = "State was not changed"
    end
      redirect_to list_tasks_path(@list)
  end


  private

  def authenticate
    deny_access unless signed_in?
  end

end
