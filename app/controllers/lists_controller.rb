class ListsController < ApplicationController

  def new
    @title = "New List"
    if params[:project_id]
      @project = Project.find(params[:project_id])
      @list = @project.lists.build
    else
      @list = current_user.lists.build
    end
   @button_name = "New"
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
      flash[:error] = "List wasn't update successfully updated"
      render 'edit'
    end
  end


  def create
    @title = "Create List"
    @list=List.new(params[:list])
    if params[:project_id]
      @list.project_id = params[:project_id]
    end
    @list.user_id = current_user.id
    if @list.save
      flash[:success] = 'List was successfully created'
      if params[:project_id]
        redirect_to project_lists_path(@project)
      else
        redirect_to lists_path
      end
    else
      flash[:error] = "List wasn't create successfully created"
      render 'new'
    end
  end


  def destroy
    @list=List.find(params[:id])
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
end
