class ListsController < ApplicationController

  def new
    @title = "New List"
    @user = User.find(params[:user_id])
   if !(params[:project_id].nil?)
      @project = @user.projects.find(params[:project_id])
      @list=@project.lists.build
    else
      @list = @user.lists.build
    end
    @button_name = "New"
  end

  def index
    @title = "Index List"
    @user = User.find_by_id(params[:user_id])
    if (params[:project_id])
      @project = @user.projects.find(params[:project_id])
      @lists = @project.lists.all
    else
      @lists = @user.lists
    end
  end

  def show
    @title = "Show List"
    @user = User.find(params[:user_id])

    if !(params[:project_id].nil?)
      @project = @user.projects.find(params[:project_id])
      @list=@projects.lists.find(params[:id])
    else
       @list =@user.lists.find(params[:id])
    end
  end

  def edit
    @title = "Edit List"
    @user= User.find(params[:user_id])

    if !(params[:project_id].nil?)
      @project = @user.projects.find(params[:project_id])
      @list=@projects.lists.find(params[:id])
    else
       @list =@user.lists.find(params[:id])
    end
    @button_name = "Update"
  end

def update
    @title = "Update List"
    @user = User.find(params[:user_id])
    if !(params[:project_id].nil?)
      @project = @user.projects.find(params[:project_id])
      @list=@projects.lists.find(params[:id])
    else
       @list =@user.lists.find(params[:id])
    end
    if @list.update_attributes(params[:list])
      if !(params[:project_id].nil?)
        redirect_to user_project_lists_path(@user,@project)
      else
        redirect_to user_lists_path(@user)
      end
    else
      render 'edit'
    end
  end


  def create
    @title = "Create List"
    @user = User.find(params[:user_id])

    if (params[:project_id])
      @project = @user.projects.find(params[:project_id])
      @list=@project.lists.build(params[:list])
      @list.project_id = params[:project_id]
      @list.user_id = params[:user_id]
    else
      @list = @user.lists.build(params[:list])

    end
    if @list.save
      flash[:notice] = 'List was successfully created'
      if !(params[:project_id].nil?)
        redirect_to user_project_lists_path(@user,@project)
      else
        redirect_to user_lists_path(@user)
      end
    else
      render 'new'
    end
  end


  def destroy
    @user = User.find(params[:user_id])
    if !(params[:project_id].nil?)
      @project = @user.projects.find(params[:project_id])
      @list=@projects.lists.find(params[:id])
    else
       @list =@user.lists.find(params[:id])
    end
    @list.destroy
    flash[:success] = "List is destroyed."
    if !(params[:project_id].nil?)
        redirect_to user_project_lists_path(@user,@project)
      else
        redirect_to user_lists_path(@user)
      end
  end
end
