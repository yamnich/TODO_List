class ProjectsController < ApplicationController
  def new
    @title = "New Project"
    @project = Project.new
    @button_name = "New"
  end

  def index
    @title = "Index Projects"
    @projects=Project.where("user_id = ?", current_user.id)
  end

  def show
    @project = Project.find(params[:id])
    redirect_to lists_path
  end

  def edit
    @title = "Edit Project"
    @project = Project.find(params[:id])
    @project.user_id=current_user.id
    @button_name = "Update"
  end

  def create
    @title = "Create Project"
    @project = Project.create(params[:project])
    @project.user_id = current_user.id
    if @project.save
      flash[:notice] = 'Project was successfully created'
      redirect_to projects_path
    else
      render 'new'
    end
  end

   def update
      @title = "Update Project"
      @project = Project.find(params[:id])
      @project.user_id=current_user.id
      if @project.update_attributes(params[:project])
        redirect_to projects_path
      else
        render 'edit'
      end
    end

   def destroy
     @project = Project.find(params[:id])
     @project.destroy
     flash[:success] = "Project is destroyed."
     redirect_to projects_path
   end

  end

