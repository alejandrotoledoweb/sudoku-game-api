class MovesController < ApplicationController

  def create
    @move = Move.new(move_params)

    # render json: {move: @move.number}, status: :created
  # end
    id = @move.game_id
    @game = Game.find(@move.game_id)
    board = parse_board(@game.board)
    string_board = board.join("")
    solution_board = @game.solution
    row = @move.row
    col = @move.col
    number = @move.number

    if check_value(board, row, col, number)
      @move.save
      update_board(board, id, row, col, number)
      render json: {board: board, message: "not solved"}, status: :ok
    else
      render json: {board: board, error: "number duplicated"}, status: :not_acceptable
    end

    if check_solution(string_board, solution_board)
      render json: {board: board, message: "solved"}, status: :ok
    end
    

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
    result = []

    for i in 0...board_string.length do
      if i % 9 == 0
        result.push(board_string[i...i + 9].split("").map(&:to_i))
      end
    end
    result
    # render json: {board: @result}, status: :ok
  end

  def parse_solution(board_string)
    # @board_string = @game.board
    result = []

    for i in 0...board_string.length do
      if i % 9 == 0
        result.push(board_string[i...i + 9].split("").map(&:to_i))
      end
    end
    result
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

  def check_solution(board, solution)
    if board == solution
      return true
    else
      return false
    end
    
  end
  

  def solve(board_string)
    board = parse_board(board_string)
    empty_positions = find_empty_positions(board)
  
    solve_puzzle(board, empty_positions)
  end

  def solve_puzzle(board, empty_positions)
    i = 0
    
    while i < empty_positions.length
      row = empty_positions[i][0]
      column = empty_positions[i][1]
      number = board[row][column] + 1
      found = false
  
      while !found && number <= 9
        if check_value(board, row, column, number)
          found = true
          board[row][column] = number
          i += 1
        else
          number += 1
        end
      end
  
      if !found
        board[row][column] = 0
        i -= 1
      end
    end
    
    board
  end

  def update_board(board, id, row, col, number)
    @game = Game.find(id)
    board[row][col] = number
    board
    # string_board = board.join("")
    # @game.update_attribute(board: string_board)
    # head :no_content
  end

  private

  def move_params
    params.permit(:game_id, :row, :col, :number)
  end
  
  
end
