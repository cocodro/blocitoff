class TasksController < ApplicationController

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
      flash[:notice] = "Task deleted."
      redirect_to @list
    else
      flash[:error] = "Failed to delete task."
      redirect_to :back
    end
  end

  private

  def task_params
    params.require(:task).permit(:description)
  end
end
