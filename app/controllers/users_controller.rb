class UsersController < ApplicationController
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
      redirect_to user_lists_path(@user)
    end

    def edit
      @title = "Edit User"
      @user = User.find(params[:id])
      @button_name = "Update"
    end

    def create
      @user = User.new(params[:user])
      if @user.save
        flash[:success] = "Welcome!"
        redirect_to user_lists_path(@user)
      else
        @title = "Sign up"
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
