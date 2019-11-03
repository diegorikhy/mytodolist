class BoardsController < ApplicationController
  def index
    respond_to do |format|
      format.html { render layout: 'application' }
      format.json {
        boards = Board.all.order(:title)
        render json: { items: boards.map(&:to_obj) }
      }
    end
  end

  def show
    board = Board.preload(steps: :tasks).where(id: params[:id]).first

    return render json: {}, status: :not_found if board.blank?
    return render json: board.to_show_obj, status: :ok
  end

  def create
    board = Board.new(board_params)

    return render json: board.to_obj, status: :ok if board.save
    render json: errors_full_messages(board), status: :unprocessable_entity
  end

  def update
    board = get_board

    return render json: {}, status: :not_found    if board.blank?
    return render json: board.to_obj, status: :ok if board.update(board_params)
    render json: errors_full_messages(board), status: :unprocessable_entity
  end

  def destroy
    board = get_board

    return render json: {}, status: :not_found    if board.blank?
    return render json: board.to_obj, status: :ok if board.destroy
    render json: errors_full_messages(board), status: :unprocessable_entity
  end

  private

  def get_board
    Board.where(id: params[:id]).first
  end

  def errors_full_messages board
    { errors: board.errors.full_messages }
  end

  def board_params
    params.require(:board).permit(:title)
  end
end
