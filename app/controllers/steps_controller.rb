class StepsController < ApplicationController
  def index
    respond_to do |format|
      format.html { render layout: 'application' }
      format.json {
        steps = Step.all
        render json: { items: steps.map(&:to_obj) }
      }
    end
  end

  def show
    step = get_step

    return render json: {}, status: :not_found if step.blank?
    return render json: step.to_show_obj, status: :ok
  end

  def create
    step = Step.new(step_params)

    return render json: step.to_obj, status: :ok if step.save
    render json: errors_full_messages(step), status: :unprocessable_entity
  end

  def update
    step = get_step

    return render json: {}, status: :not_found    if step.blank?
    return render json: step.to_obj, status: :ok if step.update(step_params)
    render json: errors_full_messages(step), status: :unprocessable_entity
  end

  def destroy
    step = get_step

    return render json: {}, status: :not_found    if step.blank?
    return render json: step.to_obj, status: :ok if step.destroy
    render json: errors_full_messages(step), status: :unprocessable_entity
  end

  private

  def get_step
    Step.find(params[:id])
  end

  def errors_full_messages step
    { errors: step.errors.full_messages }
  end

  def step_params
    params.require(:step).permit(:title, :board_id)
  end
end
