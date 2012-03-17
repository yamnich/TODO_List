class ListsController < ApplicationController
  before_filter :authenticate

  def new
    @title = "New List"
    if params[:project_id]
      @project = current_user.own_projects.find(params[:project_id])
      @list = @project.lists.build
    else
      @list = current_user.lists.build
    end
   @button_name = "New"
  end

  def create
    @title = "Create List"
    @list=current_user.lists.new(params[:list])
    if params[:project_id]
      @list.project_id = params[:project_id]
    else
      @list.project_id = nil
    end
    if @list.save
      flash[:success] = 'List was successfully created'
      if params[:project_id]
        redirect_to project_lists_path(@project)
      else
        redirect_to lists_path
      end
    else
      flash[:error] = "List wasn't  successfully created"
      render 'new'
    end
  end

  def index
    @title = "Index List"
    if params[:project_id]
     @project = Project.find(params[:project_id])
     @lists = @project.lists.all
    else
      @lists = current_user.lists.all
    end
  end

  def edit
    @title = "Edit List"
    @list=List.find(params[:id])
    @button_name = "Update"
  end

  def update
    @title = "Update List"
    @list = List.find(params[:id])
    if @list.update_attributes(params[:list])
      flash[:success] = 'List was successfully updated'
      if params[:project_id]
        redirect_to project_lists_path(@project)
      else
        redirect_to lists_path
      end
    else
      flash[:error] = "List wasn't successfully updated"
      render 'edit'
    end
  end

  def destroy
    @list=current_user.lists.find(params[:id])
     if @list.destroy
      flash[:success] = "List is destroyed."
      if params[:project_id]
        redirect_to project_lists_path(@project)
      else
        redirect_to lists_path
      end
     else
       flash[:error] = "List wasn't destroyed."
     end
  end

  def authenticate
    deny_access unless signed_in?
  end
end
