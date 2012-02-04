class TasksController < ApplicationController
  respond_to :html, :xml, :json
  def new
    @title = "New_Task"
    @list =  List.find(params[:list_id])
    @project=@list.project
    if !@project.nil?
      @members=@project.members
    end

    @task = @list.tasks.build
    @button_name = "New"
  end

  def create
    @list = List.find(params[:list_id])
    @task = @list.tasks.build(params[:task])
    @title = 'Creating task'
    if @task.save
      flash[:notice] = 'Task was successfully created'
        redirect_to list_tasks_path(@list)
    else
      render 'new'
    end
  end

  def index
     @title = "index_task"
     @list= List.find(params[:list_id])
    # @project = Project.find(@list.project_id)
     if params[:state] == "done"
       @tasks = @list.tasks.where("state = 'Done'")
     elsif params[:state] == "in_work"
       @tasks = @list.tasks.where("state = 'In work'")
     else
       @tasks = @list.tasks
     end
  end

  def edit
    @list =List.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    @button_name = "Update"
  end

  def update
    @list =List.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    if @task.update_attributes(params[:task])
      redirect_to list_tasks_path(@list)
    else
      render 'edit'
    end
  end


  def destroy
    @list =List.find(params[:list_id])

    @task = @list.tasks.find(params[:id])
    @task.destroy
    flash[:success] = "Task is destroyed."
    redirect_to list_tasks_path( @list)

  end

  def change_state
    @list =List.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    if  @task.state == "Done"
    @task.state = "In work"
    else @task.state = "Done"
    end
        if @task.update_attributes(params[:task])
          flash[:success] = "Task was updated successfully"
        else
          flash[:error] = "Task was not updated"
        end
        redirect_to list_tasks_path(@list)
  end


end
