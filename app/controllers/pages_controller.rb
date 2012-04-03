class PagesController < ApplicationController
  def home
    @title = "Home"
    @projects = current_user.own_projects
    @projects_invited_in = current_user.projects

    @lists = current_user.lists.where("project_id is NULL") # @project.lists).compact
    @projects.each do |project|
      @lists = @lists | project.lists
    end
    @projects_invited_in.each do |project|
      @lists = @lists | project.lists
    end
    @lists = @lists.compact
    @tasks = Array.new()
    @lists.each do |list|
      @tasks = (@tasks | list.tasks).compact
    end
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

end
