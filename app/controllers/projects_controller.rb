class ProjectsController < ApplicationController
  load_and_authorize_resource

  # GET /projects/new
  # GET /projects/new.json
  def new
  end

  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.own_projects
    @projects_invited_in = current_user.projects
    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    redirect_to lists_path

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end
  # GET /projects/1/edit
  def edit
  end
  # POST /projects
  # POST /projects.json
  def create
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /project/1
  # PUT /project/1.json
   def update
     respond_to do |format|
        if @project.update_attributes(params[:project])
          format.html { redirect_to @project, notice: 'Project was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
   end
  # DELETE /project/1
  # DELETE /project/1.json
   def destroy
     if @project.destroy
      flash[:success] = 'Project was successfully destroyed'
     else
      flash[:error] = "Project wasn't destroyed"
     end
     redirect_to projects_path
     respond_to do |format|
       format.html { redirect_to projects_url }
       format.json { head :no_content }
     end
   end


  end

