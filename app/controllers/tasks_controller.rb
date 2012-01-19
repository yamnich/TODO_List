class TasksController < ApplicationController
  respond_to :html, :xml, :json
  def new
    @title = "New_Task"
    @user = User.find(params[:user_id])
    @list =  @user.lists.find(params[:list_id])
    @task = @list.tasks.build
    @button_name = "New"
    respond_with(@task)
  end

  def index
    @title = "index_task"
    @user=User.find(params[:user_id])
    @list= @user.lists.find(params[:list_id])
    if params[:state] == "done"
      @tasks = @list.tasks.where("state = 'Done'")
    elsif params[:state] == "in_work"
      @tasks = @list.tasks.where("state = 'In work'")
    else
      @tasks = @list.tasks
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @list= @user.lists.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    @button_name = "Update"
  end

  def update
    @user = User.find(params[:user_id])
    @list = @user.lists.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    if @task.update_attributes(params[:task])
      redirect_to user_list_tasks_path(@user, @list)
    else
      render 'edit'
    end
  end

  def create
    @user = User.find(params[:user_id])
    @list = @user.lists.find(params[:list_id])
    @task = @list.tasks.build(params[:task])
    @title = 'Creating task'
    if @task.save
      flash[:notice] = 'Task was successfully created'
      redirect_to user_list_tasks_path(@user, @list)
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @list = @user.lists.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    @task.destroy
    flash[:success] = "Task is destroyed."
    redirect_to user_list_tasks_path
  end

  def change_state
    @user = User.find(params[:user_id])
    @list = @user.lists.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    if  @task.state == "Done"
    @task.state = "In work"
    else @task.state = "Done"
    end
    if @task.update_attributes(params[:task])
      redirect_to user_list_tasks_path(@user, @list)
    else
      redirect_to user_list_tasks_path(@user, @list)
    end
  end


end
