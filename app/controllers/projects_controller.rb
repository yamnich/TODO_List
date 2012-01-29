class ProjectsController < ApplicationController
  def new
      @title = "New Project"
      @project = current_user.projects.build
      @button_name = "New"
  end

  def index
    @title = "Index Projects"
    @projects = current_user.projects
  end

  def show
    @project = current_user.projects.find(params[:id])
    redirect_to lists_path
  end

  def edit
    @title = "Edit Project"
    @project = current_user.projects.find(params[:id])
    @button_name = "Update"

  end

  def create
    @title = "Create Project"
    @project = current_user.projects.build(params[:project])
    if @project.save
      flash[:notice] = 'Project was successfully created'
      redirect_to projects_path
    else
      render 'new'
    end
  end

  def update
      @title = "Update Project"
      @project = current_user.projects.find(params[:id])
      if @project.update_attributes(params[:project])
        redirect_to projects_path(@user)
      else
        render 'edit'
      end
    end


    def destroy
      @project = current_user.projects.find(params[:id])
      @project.destroy

      flash[:success] = "Project is destroyed."
      redirect_to projects_path(@user)
    end

  end
