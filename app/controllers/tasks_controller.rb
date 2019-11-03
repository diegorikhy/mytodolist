class TasksController < ApplicationController
  def create
    task = Task.new(task_params)

    return render json: task.to_obj, status: :ok if task.save
    render json: errors_full_messages(task), status: :unprocessable_entity
  end

  def update
    task = get_task

    return render json: {}, status: :not_found    if task.blank?
    return render json: task.to_obj, status: :ok if task.update(task_params)
    render json: errors_full_messages(task), status: :unprocessable_entity
  end

  def destroy
    task = get_task

    return render json: {}, status: :not_found    if task.blank?
    return render json: task.to_obj, status: :ok if task.destroy
    render json: errors_full_messages(task), status: :unprocessable_entity
  end

  private

  def get_task
    Task.where(id: params[:id]).first
  end

  def errors_full_messages task
    { errors: task.errors.full_messages }
  end

  def task_params
    params.require(:task).permit(:title, :step_id)
  end
end
