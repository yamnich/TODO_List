class ProjectsController < ApplicationController
  before_filter :authenticate

  def new
    @title = "New Project"
    @project = current_user.projects.new
    @button_name = "New"
  end

  def index
    @title = "Index Projects"
    @projects=current_user.own_projects
    @projects_invited_in = current_user.projects_invited_in
  end

  def show
    @project = current_user.projects.find(params[:id])
    redirect_to lists_path
  end

  def edit
    @title = "Edit Project"
    @project = Project.find(params[:id])
    @button_name = "Update"
  end

  def create
    @title = "Create Project"
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
      if @project.update_attributes(params[:project])
        flash[:success] = 'Project was successfully updated'
        redirect_to projects_path
      else
        flash[:error] = "Project wasn't updated"
        render 'edit'
      end
    end

   def destroy
     @project = current_user.own_projects.find(params[:id])
     if @project.destroy
      flash[:success] = "Project was successfully deleted"
     else
      flash[:error] = "Project wasn't deleted"
     end
     redirect_to projects_path
   end

  def invite
    @project = current_user.own_projects.find(params[:id])
  end


  def invite_the_user
    @project = current_user.own_projects.find(params[:id])
    @member = User.find_by_email(params[:email])

    if @member.nil?
      flash[:error] = 'There is no user with such email'
    else
      if !@member.member?(@project)
        @member.join!(@project)
        UserMailer.invite(@member,@project.name).deliver
        flash[:success]="User was invited"
      end
    end
      redirect_to members_project_path(@project)
  end

  def members
    @project = Project.find(params[:id])
  end

  def remove_member
    @project = current_user.own_projects.find(params[:id])
    @member = User.find(params[:member_id])
    @member.leave!(@project)
    flash[:success] = "User was deleted from project"
    redirect_to  members_project_path(@project)
  end

  private

  def authenticate
    deny_access unless signed_in?
  end



  end

