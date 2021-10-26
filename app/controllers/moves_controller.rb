class MovesController < ApplicationController

  def create
    @move = Move.new(move_params)
  end

  def check_value(board, row, col, number)
    check_row(board, row, number) &&
      check_col(board, col, number) &&
      check_block(board, row, col, number)
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

  def check_block(board, row, col, number)
    lower_row = 3 * (row / 3)
    lower_col = 3 * (col / 3)
    upper_row = lower_row + 3
    upper_col = lower_col + 3
  
    for r in lower_row...upper_row
      for c in lower_col...upper_col
        if board[r][c] == number
          return false
        end
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
