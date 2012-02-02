class ListsController < ApplicationController

  def new
    @title = "New List"
    if !(params[:project_id].nil?)
      @project = Project.find(params[:project_id])
      @list = @project.lists.build
    else
      @list = current_user.lists.build
    end
   @button_name = "New"
  end

  def index
    @title = "Index List"
    if !(params[:project_id].nil?)
      @project = Project.find(params[:project_id])
      @lists = @project.lists.all
    else
    #@lists = current_user.lists.where("project_id = 'nil'")
    @lists = current_user.lists.all

    end

  end

  def show
    @title = "Show List"
    @list=List.find(params[:id])
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
        redirect_to lists_path
    else
      render 'edit'
    end
  end


  def create
    @title = "Create List"
    @list=List.new(params[:list])
    @list.project_id = params[:project_id]
    @list.user_id = current_user.id
    if @list.save
      flash[:notice] = 'List was successfully created'
      if !(params[:project_id].nil?)
        redirect_to project_lists_path(@project)
      else
        redirect_to lists_path
      end
    else
      render 'new'
    end
  end


  def destroy
    @list=List.find(params[:id])
    @list.destroy
    flash[:success] = "List is destroyed."
     if !(params[:project_id].nil?)
        redirect_to project_lists_path(@project)
     else
        redirect_to lists_path
     end
  end
end
