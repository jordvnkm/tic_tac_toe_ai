require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    myboard = game.board
    node = TicTacToeNode.new(myboard, mark)
    children = node.children
    other = node.next_mover_mark


    if winner_move(game, mark) != nil
      return winner_move(game, mark)
    end



    children.each do |child|
      if !child.losing_node?(mark)
        return child.prev_move_pos
      end
    end

    raise "ERROR" if children.all? do |child|
      child.losing_node?(mark)
    end

    if winner_move(game, other) != nil
      return winner_move(game, other)
    end

    # children.each do |child|
    #   if child.winning_node?(mark)
    #     p "HERE"
    #     return child.prev_move_pos
    #   end
    # end

    # children.each do |child|
    #   p other
    #   if child.winning_node?(other)
    #     render(child.board.rows)
    #     return child.prev_mov_pos
    #   end
    # end
    raise "ERROR"
  end

  def render(board)
    board.each do |row|
      row.each do |val|
        if val == nil
          print " - "
        else
          print " #{val} "
        end
      end
      print "\n"
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
