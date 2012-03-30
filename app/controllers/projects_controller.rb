class ProjectsController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def index
    @projects = current_user.own_projects
    @projects_invited_in = current_user.projects
  end

  def show
    redirect_to lists_path
  end

  def edit
  end

  def create
    if @project.save
      flash[:success] = 'Project was successfully created'
      redirect_to projects_path
    else
      flash[:error] = "Project wasn't created"
      render 'new'
    end
  end

   def update
      if @project.update_attributes(params[:project])
        flash[:success] = 'Project was successfully updated'
        redirect_to projects_path
      else
        flash[:error] = "Project wasn't updated"
        render 'edit'
      end
    end

   def destroy
     if @project.destroy
      flash[:success] = 'Project was successfully destroyed'
     else
      flash[:error] = "Project wasn't destroyed"
     end
     redirect_to projects_path
   end


  end

