class ListsController < ApplicationController
 # respond_to :html, :xml, :js

  def new
     @title = "new_list"
     @list = List.new
  end

  def index
     @title = "index_list"
    #respond_with(@lists=List.all)
    @lists = List.all
  end

  def show
    @title = "show list"
    @list = List.find(params[:id])
  end

  def edit
    @title = "edit list"
    @list = List.find(params[:id])

  end

  def create
    @list = List.new(params[:list])
    if @list.save
      redirect_to list_tasks_path(@list)
    else
      @title = "Error"
      render 'new'
    end
  end

  def update
    @list = List.find(params[:id])
       if @list.update_attributes(params[:list])
         redirect_to lists_path
       else
         @title = "Error"
         render 'edit'
       end
  end


  def destroy
    @list = List.find(params[:id])
    @list.destroy

    flash[:success] = "List is destroyed."
   # respond_to do |format|
    #  format.html { redirect_to lists_path }
  #    format.json { head :ok }
  #  end
    redirect_to lists_path
  end

end
