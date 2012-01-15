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
    @tasks = @list.tasks
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
   # respond_to do |format|
    #  format.html { redirect_to lists_path }
  #    format.json { head :ok }
  #  end
    redirect_to user_list_tasks_path
  end

end
