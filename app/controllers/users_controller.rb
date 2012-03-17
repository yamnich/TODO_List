class UsersController < ApplicationController
  before_filter :authenticate, only: [ :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]

  def new
    @title = "Sign up"
    @user = User.new
    @button_name = "Sign up"
  end

  def show
    @user = current_user
    @title = @user.name
    @lists = @user.lists
    @projects = @user.projects
    redirect_to root_path
  end

  def edit
    @title = "Edit User"
    @button_name = "Update"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome!"
      redirect_to root_path
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile was updated"
      redirect_to root_path
    else
      flash[:error] = "Profile wasn't updated"
      @title = "Edit user"
      render 'edit'
    end
  end


  def destroy
    current_user.destroy
    flash[:success] = "User was successfully destroyed."
    redirect_to users_path
  end

  private

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user? (@user)
  end

end
