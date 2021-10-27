class GameController < ApplicationController

  before_action :set_game, only: [:show, :update]

  def create
    @game = Game.create!(game_params)
  end

  def show
    @board_string = @game.board
    @solution_string = @game.solution
    @result = []
    @solution = []


    for i in 0...@board_string.length do
      if i % 9 == 0
        @result.push(@board_string[i...i + 9].split("").map(&:to_i))
      end
    end

    for i in 0...@solution_string.length do
      if i % 9 == 0
        @solution.push(@solution_string[i...i + 9].split("").map(&:to_i))
      end
    end
    render json: {board: @result, solution: @solution}, status: :ok
  end

  private

  def game_params
    params.require(:game).permit(:board, :solution)
  end

  def set_game
    @game = Game.find(params[:id])
  end
  
  
end
