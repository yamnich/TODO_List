class ProjectMembershipsController < ApplicationController

  def new
    @project_membership=ProjectMembership.new
  end


  def create
    @project = Project.find(params[:project_id])
    @member = User.find_by_email(params[:email])

    if @member.nil?
      flash[:error] = 'There is no user with such email'
    else
      if  !@member.member?(@project)
        @member.join!(@project)
        @project.invite_user(@member)
        flash[:success]="User was invited"
      else
        flash[:notice]="User is already invited"
      end
    end
    redirect_to  project_path(@project)+'/members'
  end

  def index
    @project = Project.find(params[:project_id])
  end

  def destroy
    @project = Project.find(params[:project_id])
    @member = User.find(params[:id])
    @member.leave!(@project)? flash[:success] = "User was deleted from project" : flash[:error]= "User wasn't deleted from project"
    redirect_to  members_project_path(@project)
  end
end
