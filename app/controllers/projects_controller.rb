class ProjectsController < ApplicationController
  def new
      @title = "New Project"
      @user = User.find(params[:user_id])
      @project = @user.projects.build
      @button_name = "New"
  end

  def index
    @title = "Index Projects"
    @user = User.find(params[:user_id])
    @projects = @user.projects

  end

  def edit
    @title = "Edit Project"
    @user= User.find(params[:user_id])
    @project = @user.projects.find(params[:id])
    @button_name = "Update"
  end

  def create
    @title = "Create Project"
    @user = User.find(params[:user_id])
    @project = @user.projects.build(params[:project])
    if @project.save
      flash[:notice] = 'Project was successfully created'
      redirect_to user_projects_path(@user)
    else
      render 'new'
    end
  end

  def update
      @title = "Update Project"
      @user = User.find(params[:user_id])
      @project = @user.projects.find(params[:id])
      if @project.update_attributes(params[:project])
        redirect_to user_projects_path(@user)
      else
        render 'edit'
      end
    end


    def destroy
      @user = User.find(params[:user_id])
      @project = @user.projects.find(params[:id])
      @project.destroy

      flash[:success] = "Project is destroyed."
      redirect_to user_projects_path(@user)
    end

  end
