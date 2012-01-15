class UsersController < ApplicationController
  def new
       @title = "New User"
       @user = User.new
       @button_name = "New"
    end

    def index
      @title = "Index user"
      @users = User.all
    end

    def show
      @title = "Show User"
      @user = User.find(params[:id])
    end

    def edit
      @title = "Edit User"
      @user = User.find(params[:id])
      @button_name = "Update"
    end

    def create
      @title = "Create User"
      @user = User.new(params[:user])
      if @user.save
        redirect_to @user
      else
        render 'new'
      end
    end

    def update
      @title = "Update user"
      @user = User.find(params[:id])
         if @user.update_attributes(params[:user])
           redirect_to @user
         else
           render 'edit'
         end
    end


    def destroy
      @user = User.find(params[:id])
      @user.destroy

      flash[:success] = "User was successfully destroyed."
     # respond_to do |format|
      #  format.html { redirect_to lists_path }
    #    format.json { head :ok }
    #  end
      redirect_to users_path
    end

end
