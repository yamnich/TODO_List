class TasksController < ApplicationController
  load_and_authorize_resource :list
  load_and_authorize_resource :task, through: :list

  def index
    params[:state]? @tasks = @list.tasks.where("state = ?", params[:state]) : @tasks = @list.tasks
    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @tasks }
    end
  end

  def new
    @project = @list.project
    @members=@project.members if @project

  end

  def create
    #@task.send_email_to(current_user)
      respond_to do  |format|
        if @task.save
          format.html { redirect_to list_tasks_path(@list), success: 'Task was successfully created' }
          format.json { render json: @task, status: :created, location: [@list, @task] }
        else
          format.html { render action: "new", error: "Task wasn't created" }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @task.update_attributes(params[:task])
        #@task.send_email_to(@task.executor)
        format.html { redirect_to  list_tasks_path(@list), success: 'Task was successfully updated' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" , error: "Task wasn't updated"}
        format.json { render json: @task.errors,  status: :unprocessable_entity }
      end
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
