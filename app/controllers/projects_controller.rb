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
    ############################
    #@project = current_user.projects.build(params[:project])
    @project = Project.new(params[:project])
    @project.user_id = current_user.id
    if @project.save
      flash[:success] = 'Project was successfully created'
      redirect_to projects_path
    else
      flash[:error] = "Project wasn't created. Please try again"
      render 'new'
    end
  end

   def update
      @title = "Update Project"
      @project = Project.find(params[:id])
      @project.user_id=current_user.id
      if @project.update_attributes(params[:project])
        flash[:success] = 'Project was successfully updated'
        redirect_to projects_path
      else
        flash[:error] = "Project wasn't updated"
        render 'edit'
      end
    end

   def destroy
     @project = Project.find(params[:id])
     @project.destroy
     flash[:success] = "Project was successfully deleted"
     redirect_to projects_path
   end

  end

