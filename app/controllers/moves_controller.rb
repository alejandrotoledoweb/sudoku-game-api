class MovesController < ApplicationController

  def create
    @move = Move.new(move_params)
  end

  def check_row(board, row, number)
    for col in 0...board[row].length
      if board[row][col] == number
        return false
      end
    end
  
    true
  end

  def check_col(board, col, number)
    for row in 0...board.length
      if board[row][col] == number
        return false
      end
    end
  
    true
  end

  def parse_board(board_string)
    # @board_string = @game.board
    @result = []

    for i in 0...board_string.length do
      if i % 9 == 0
        @result.push(board_string[i...i + 9].split("").map(&:to_i))
      end
    end
    @result
    # render json: {board: @result}, status: :ok
  end

  def find_empty_positions(board)
    empty_positions = []
  
    for row in 0...board.length
      for col in 0...board[row].length
        if board[row][col] == 0
          empty_positions << [row, col]
        end
      end
    end
  
    empty_positions
  end

  private
  def move_params
    params.require(:move).permit(:game, :row, :col, :number)
  end
  
  
end
