class TasksController < ApplicationController
  respond_to :html, :js

  def new
    @list = List.find(params[:list_id])
    @task = Task.new
    @task.list = @list
  end

  def create
    @list = List.find(params[:list_id])
    @task = Task.new(task_params)
    @task.list = @list
    if @task.save
      flash[:notice] = "New task created!"
      redirect_to @list
    else
      flash[:error] = "Failed to create new task."
      redirect_to :back
    end
  end

  def destroy
    @list = List.find(params[:list_id])
    @task = Task.find(params[:id])
    if @task.destroy
      flash[:notice] = "Task completed! Way to go!"
    else
      flash[:error] = "Failed to remove task from list!"
    end

    respond_with(@task) do |format|
      format.html { redirect_to @list }
    end
  end

  private

  def task_params
    params.require(:task).permit(:description)
  end
end
