class TasksController < ApplicationController

  def index
    @tasks = Task.all
    render json: @tasks
  end

  def show
    @task = Task.find(params[:id])
    render json: @task
  end

  def create
    @task = Task.create params.require(:task).permit(:name, :start, :end)
    render json: @task
  end

  def update
    @task = Task.find(params[:id])
    @task = @task.update params.require(:task).permit(:name, :start, :end)
    render json: @task
  end

end
