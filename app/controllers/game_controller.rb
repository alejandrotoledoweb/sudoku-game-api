class GameController < ApplicationController

  def create
    @game = Game.create!(game_params)
  end

  def show
    @game = Game.find(params[:id])
    @board_string = @game.board
    @result = []

    for i in 0...@board_string.length do
      if i % 9 == 0
        @result.push(@board_string[i...i + 9].split("").map(&:to_i))
      end
    end
  
    render json: {board: @result}, status: :ok
    
  end
  

  private

  def game_params
    params.require(:game).permit(:board, :solution)
  end
  
  
end
