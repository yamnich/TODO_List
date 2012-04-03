class ListsController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :list, through: :project,  shallow: true


  def index
    @project? @lists = @project.lists : @lists = current_user.lists.where("project_id is NULL")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lists }
    end
  end

  def new
  end

  def create
    respond_to do  |format|
    if @list.save
      if @project
        format.html { redirect_to project_lists_path(@project), success: 'Task list was successfully created' }
      else
        format.html { redirect_to lists_path, success: 'Task list was successfully created' }
      end
      format.json { render json: @list, status: :created, location: @list }
    else
      format.html { render action: "new", error: "List wasn't created" }
      format.json { render json: @list.errors, status: :unprocessable_entity }
    end
    end
  end


  def edit
  end

  def update
    if @list.update_attributes(params[:list])
      flash[:success] = 'List was successfully updated'
      @project? redirect_to(project_lists_path(@project)) : redirect_to(lists_path)
    else
      flash[:error] = "List wasn't updated"
      render 'edit'
    end
  end

  def destroy
     if @list.destroy
      flash[:success] = "List was destroyed"
      @project? redirect_to(project_lists_path(@project)) : redirect_to(lists_path)
     else
      flash[:error] = "List wasn't destroyed"
     end
  end

end
