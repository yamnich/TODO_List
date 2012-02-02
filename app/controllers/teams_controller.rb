class TeamsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @team=Team.new
    @button_name = "Invite user"
  end

  def create
   #   @project = Project.find(params[:team][:project_id])
     # current_user.join!(@project)
      #redirect_to project_lists_path(@project)

   # @team.project_id= params[:project_id]
    @member =User.find_by_email(params[:email])
    @project = Project.find(params[:project_id])
   # if @member.nil?
     #  flash[:error]='User is not defined'
       #render  'new'
     #else
       #@team.user_id=@member.id
       @team=Team.create!(:user_id => @member.id, :project_id =>@project.id )
   #  end
    if @team.save
      flash[:notice] = 'User was invited to the project successfully'
      redirect_to project_path(@project)+'/members'
    else
      render 'new'
    end

   end

  def destroy
    @teams = Team.find(params[:id])

    @team.delete
    flash[:success] = "User is deleted."
   # @project = Project.find(params[:id])

    redirect_to project_path(@project)+'/members'
  end

  def show
    @project=Project.find(params[:project_id])
    @teams=@project.teams.all
    #@teams.each  do |team|
      # @members << User.where("user_id = ?", team.user_id )
    #end
  end
end
