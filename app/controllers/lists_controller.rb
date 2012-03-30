class ListsController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :list, through: :project,  shallow: true


  def index
    @project? @lists = @project.lists : @lists = current_user.lists.where("project_id is NULL")
  end

  def new
  end

  def create
    if @list.save
      flash[:success] = 'List was successfully created'
      @project? redirect_to(project_lists_path(@project)) : redirect_to(lists_path)
    else
      flash[:error] = "List wasn't created"
      render 'new'
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
