class MovesController < ApplicationController

  def create
    @move = Move.new(move_params)

    id = @move.game_id
    @game = Game.find(@move.game_id)
    board = parse_board(@game.board)
    solution_board = @game.solution
    row = @move.row
    col = @move.col
    number = @move.number

    if check_value(board, row, col, number)
      @move.save
      new_board = update_board(board, id, row, col, number, solution_board)
      string_new = new_board.join('')
      if check_solution(string_new, solution_board)
        render json: {board: new_board, solution: solution_board, message: "Solved, congratulations!"}, status: :ok
      else
        render json: {board: board, message: "good, but not solved yet!"}, status: :ok
      end
    else
      render json: {board: board, error: "number duplicated or not allowed"}, status: :not_acceptable
    end
  end

  def check_value(board, row, col, number)
    empty_positions = find_empty_positions(board)
    if number == 0 && check_empty_positions(row, col, empty_positions)
      return true
    else
      check_row(board, row, number) &&
      check_col(board, col, number) &&
      check_block(board, row, col, number) &&
      check_empty_positions(row, col, empty_positions)

    end
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

  def check_empty_positions(row, col, empty_positions)
    for e in 0..empty_positions.length-1 do
      if empty_positions[e].include?(row) && empty_positions[e].include?(col)
        return true
      else
        return false
      end
    end
    
  end
  

  def parse_board(board_string)
    result = []

    for i in 0...board_string.length do
      if i % 9 == 0
        result.push(board_string[i...i + 9].split("").map(&:to_i))
      end
    end
    result
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

  def check_solution(board, solution)
    if board === solution
      return true
    else
      return false
    end
    
  end

  def update_board(board, id, row, col, number, solution)
    @game = Game.find(id)
    board[row][col] = number
    string_board = board.join("")
    @game.update(board: string_board, solution: solution)
    board
  end

  private

  def move_params
    params.permit(:game_id, :row, :col, :number)
  end
  
  
end
