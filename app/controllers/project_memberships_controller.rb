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
   # @project_membership = ProjectMembership.find(params([:project_id] [ :member_id]))
    @project = Project.find(params[:project_id])
    @member = User.find(params[:id])
    #@project_membership = ProjectMembership.where('user_id = ? and project_id =?', @member.id, @project.id)
    #@project_membership.first.destroy if !@project_membership.first.nil?

    @project.members.delete(@member)
    flash[:success] = "User was deleted from project"
   # flash[:error] = "It is impossible to delete user from project"
      #@member.leave!(@project)

    #redirect_to   :back#project_path(@project)+'/members'
    redirect_to members_project_url(@project)
  end

end
