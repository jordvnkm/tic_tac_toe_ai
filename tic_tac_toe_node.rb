require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @children = []
  end

  def losing_node?(evaluator)
    if @board.over?
      return true if @board.winner != evaluator
      return false if @board.winner == nil || @board.winner == evaluator
    end

    @children = children
    # p @children
    if next_mover_mark != evaluator
      return true if @children.all? do |child|
        child.losing_node?(evaluator)
      end
      return false
    else
      return true if @children.any? do |child|
        child.losing_node?(evaluator)
      end
      return false
    end
  end

  def full?
    @board.grid.each do |row|
      row.each do |tile|
        if !tile.empty?
          return false
        end
      end
    end
    true
  end

  def winning_node?(evaluator)
    if @board.over?
      return false if @board.tied?
      return true if @board.winner == evaluator
      return false if @board.winner == nil || @board.winner != evaluator
    end
    @children = children
    if @next_mover_mark != evaluator
      return true if @children.all? do |child|
        child.winning_node?(evaluator)
      end
      return false
    else
      return true if @children.any? do |child|
        child.winning_node?(evaluator)
      end
      return false
    end


  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    rounds = []
    @next_mover_mark
    @board.rows.each_with_index do |row,ridx|
      row.each_with_index do |tile,cidx|
        if tile == nil
          new_board = @board.dup
          new_board[[ridx,cidx]] = @next_mover_mark
          rounds << TicTacToeNode.new(new_board, rotate_player, [ridx, cidx])
        end
      end
    end
    @next_mover_mark = rotate_player
    rounds
  end

  def rotate_player
    if @next_mover_mark == :x
      return :o
    else
      return :x
    end
  end
end
