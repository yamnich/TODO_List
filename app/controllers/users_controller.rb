class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy


  def new
       @title = "New User"
       @user = User.new
       @button_name = "Sign up"
    end

    def index
      @title = "Index user"
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
      @title = @user.name
     #redirect_to user_path(@user)
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
        redirect_to user_path(@user)
      else
        @title = "Sign up"
        render 'new'
      end
    end

    def update
      @user = User.find(params[:id])
         if @user.update_attributes(params[:user])
           flash[:success] = "Profile update."
           redirect_to @user
         else
           @title = "Edit user"
           render 'edit'
         end
    end


    def destroy
       User.find(params[:id]).destroy
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

    def admin_user
      redirect_to (root_path) unless current_user.admin?
    end

end
