class ProjectMembershipsController < ApplicationController
 def invite
   @project_membership=ProjectMembership.new
   @button_name = "Invite"
 end

  def create
    @project = Project.find(params[:project_id])
    @member = User.find_by_email(params[:email])
    if !@member.member?(@project)
     @member.join!(@project)
     UserMailer.invite(@member,@project.name).deliver
     flash[:success]="User was invited"
    end
    redirect_to  project_project_memberships_path(@project)
  end

  def members
    @project = Project.find(params[:project_id])
  end


  def destroy
    @project = Project.find(params[:project_id])
    @member = User.find(params[:id])
    @member.leave!(@project)
    flash[:success] = "User was deleted from project"
    redirect_to  project_project_memberships_path(@project)
  end

end
