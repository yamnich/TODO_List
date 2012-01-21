class TasksController < ApplicationController
  respond_to :html, :xml, :json
  def new
    @title = "New_Task"
    @user = User.find(params[:user_id])
    if !(params[:project_id].nil?)
      @project = @user.projects.find(params[:project_id])
      @list = @project.lists.find(params[:list_id])
    else
      @list =  @user.lists.find(params[:list_id])
    end
    @task = @list.tasks.build
    @button_name = "New"
    #respond_with(@task)
  end

  def create
    @user = User.find(params[:user_id])
    p_id=params[:project_id]
    if !(params[:project_id].nil?)
      @project = @user.projects.find(params[:project_id])
      @list=@project.lists.find(params[:list_id])
    else
      @list = @user.lists.find(params[:list_id])
    end
    @task = @list.tasks.build(params[:task])
    @title = 'Creating task'
    if @task.save
      flash[:notice] = 'Task was successfully created'
      if !(params[:project_id].nil?)
        redirect_to user_project_list_tasks_path(@user,@project,@list)
      else
        redirect_to user_list_tasks_path(@user,@list)
      end
    else
      render 'new'
    end
  end

  def index
    @title = "index_task"
    @user=User.find(params[:user_id])
    if !(params[:project_id].nil?)
      @project = @user.projects.find(params[:project_id])
      @list = @project.lists.find(params[:list_id])
    else
      @list= @user.lists.find(params[:list_id])
    end
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
    if !(params[:project_id].nil?)
      @project = @user.projects.find(params[:project_id])
      @list=@projects.lists.find(params[:list_id])
    else
       @list =@user.lists.find(params[:list_id])
    end

    @task = @list.tasks.find(params[:id])
    @button_name = "Update"
  end

  def update
    @user = User.find(params[:user_id])
     if !(params[:project_id].nil?)
      @project = @user.projects.find(params[:project_id])
      @list=@projects.lists.find(params[:list_id])
    else
       @list =@user.lists.find(params[:list_id])
    end

    @task = @list.tasks.find(params[:id])
    if @task.update_attributes(params[:task])
      if !(params[:project_id].nil?)
        redirect_to user_project_list_tasks_path(@user,@project,@list)
      else
        redirect_to user_list_tasks_path(@user,@list)
      end
    else
      render 'edit'
    end
  end


  def destroy
    @user = User.find(params[:user_id])
    if !(params[:project_id].nil?)
      @project = @user.projects.find(params[:project_id])
      @list=@project.lists.find(params[:list_id])
    else
       @list =@user.lists.find(params[:list_id])
    end
    @task = @list.tasks.find(params[:id])
    @task.destroy
    flash[:success] = "Task is destroyed."
    if !(params[:project_id].nil?)
        redirect_to user_project_list_tasks_path(@user,@project,@list)
      else
        redirect_to user_list_tasks_path(@user, @list)
      end
  end

  def change_state
    @user = User.find(params[:user_id])
    if !(params[:project_id].nil?)
      @project = @user.projects.find(params[:project_id])
      @list=@projects.lists.find(params[:list_id])
    else
       @list =@user.lists.find(params[:list_id])
    end
    @task = @list.tasks.find(params[:id])
    if  @task.state == "Done"
    @task.state = "In work"
    else @task.state = "Done"
    end

      if !(params[:project_id].nil?)
        if @task.update_attributes(params[:task])
          flash[:success] = "Task was updated successfully"
        else
          flash[:error] = "Task was not updated"
        end
        redirect_to user_project_list_tasks_path(@user,@project,@list)
      else
         if @task.update_attributes(params[:task])
          flash[:success] = "Task was updated successfully"
        else
          flash[:error] = "Task was not updated"
        end
        redirect_to user_list_tasks_path(@user,@list)
      end

  end


end
