class TasksController < ApplicationController
  respond_to :html, :xml, :json
  def new
    @title = "new_task"
    @list = List.find(params[:list_id])
    @task = @list.tasks.build
    respond_with(@task)
  end

  def index
     @title = "index_task"
    @list= List.find(params[:list_id])
    @tasks = @list.tasks
  end

  def edit

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

  def destroy

    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = "Task is destroyed."
   # respond_to do |format|
    #  format.html { redirect_to lists_path }
  #    format.json { head :ok }
  #  end
    redirect_to list_tasks_path
  end

end
