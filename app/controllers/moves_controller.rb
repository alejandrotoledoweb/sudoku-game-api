class MovesController < ApplicationController

  def create
    @move = Move.new(move_params)
  end

  private
  def move_params
    params.require(:move).permit(:game, :col, :row, :number)
  end
  
  
end
