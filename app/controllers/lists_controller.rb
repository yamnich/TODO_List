class ListsController < ApplicationController
 # respond_to :html, :xml, :js

  def new
    @title = "New List"
    @user = User.find(params[:user_id])
    @list = @user.lists.build
    @button_name = "New"
  end

  def index
    @title = "Index_List"
    @user = User.find(params[:user_id])
    @lists = @user.lists
  end

  def show
    @title = "Show User"
    @list = List.find(params[:id])
  end

  def edit
    @title = "Edit User"
    @user= User.find(params[:user_id])
    @list = @user.lists.find(params[:id])
    @button_name = "Update"
  end

  def create
    @title = "Create User"
    @user = User.find(params[:user_id])
    @list = @user.lists.build(params[:list])
    if @list.save
      flash[:notice] = 'List was successfully created'
      redirect_to user_lists_path(@user)
    else
      render 'new'
    end
  end


  def update
    @title = "Update User"
    @user = User.find(params[:user_id])
    @list = @user.lists.find(params[:id])
    if @list.update_attributes(params[:list])
      redirect_to user_lists_path(@user)
    else
      render 'edit'
    end
  end


  def destroy
    @user = User.find(params[:user_id])
    @list = @user.lists.find(params[:id])
    @list.destroy

    flash[:success] = "List is destroyed."
   # respond_to do |format|
    #  format.html { redirect_to lists_path }
  #    format.json { head :ok }
  #  end
    redirect_to user_lists_path(@user)
  end

end
