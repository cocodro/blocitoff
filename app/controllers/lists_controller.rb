class ListsController < ApplicationController
  def index
    @lists= List.all
  end

  def show
    if current_user.list
      @list = List.find(params[:id])
      @list = current_user.list
    end
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    if @list.save
      flash[:notice] = "New list created!"
      redirect_to @list
    else
      flash[:error] = "Failed to create list."
      redirect_to :back
    end

  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    @list.update_attributes(list_params)
    if @list.save
      flash[:notice] = "List updated!"
      redirect_to @list
    else
      flash[:error] = "Failed to update list."
      redirect_to :back
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to root_path
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end

end
