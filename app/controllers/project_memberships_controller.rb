class ProjectMembershipsController < ApplicationController
 def new
      @project_membership=ProjectMembership.new
   @button_name = "Invite"
 end

  def create
    @project = Project.find(params[:project_id])
    @member = User.find_by_email(params[:email])
   if  !@member.member?(@project)
     @member.join!(@project)
     flash[:success]="User was invited"

   end
    redirect_to  project_path(@project)+'/members'
  end

  def index
    @project = Project.find(params[:project_id])

  end


  def destroy
    @project = Project.find(params[:project_id])
    @member = User.find(params[:id])
    @member.leave!(@project)
    #@project.members.delete(@member)
    flash[:success] = "User was deleted from project"
    redirect_to members_project_url(@project)
  end

end
