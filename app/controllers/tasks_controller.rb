class TasksController < ApplicationController
  load_and_authorize_resource :list
  load_and_authorize_resource :task, through: :list

  def index
    params[:state]? @tasks = @list.tasks.where("state = ?", params[:state]) : @tasks = @list.tasks
  end

  def new
    @project = @list.project
    @members=@project.members if @project
  end

  def create
    if @task.save
      @task.send_email_to(current_user,@project)
      flash[:success] = 'Task was successfully created'
      redirect_to list_tasks_path(@list)
    else
      flash[:error] = "Task wasn't created"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update_attributes(params[:task])
      flash[:success] = 'Task was successfully updated'
      @task.send_email_to(@task.executor)
      redirect_to list_tasks_path(@list)
    else
      flash[:error] = "Task wasn't updated"
      render 'edit'
    end
  end

  def destroy
    @task.destroy ? flash[:success] = "Task was destroyed" : flash[:error] = "Task wasn't destroyed"
    redirect_to list_tasks_path(@task.list)
  end

  def change_state
    @task.change_state
    if @task.update_attributes(params[:task])
      flash[:success] = 'State was changed successfully'
    else
      flash[:error] = "State wasn't changed"
    end
    redirect_to list_tasks_path(@list)
  end

end
