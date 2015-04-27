class Sudoku
  def initialize(board_string)
    @cloned_string = board_string
    @cloned_string.gsub!(/-/, '0')
    @array_of_characters = @cloned_string.chars
    @board = []
    0.upto(8) do |i| 
      @board << @array_of_characters.slice(i * 9, 9).map{|x| x.to_i} 
    end
    p @board
  end

  def valid_row?(index_of_row)
    @board[index_of_row].reject {|i| i == 0 }.uniq == @board[index_of_row].reject {|i| i == 0 }
  end

  def valid_column?(index_of_column)
    @board.transpose[index_of_column].reject {|i| i == 0 }.uniq == @board.transpose[index_of_column].reject {|i| i == 0 }
  end
  
  def block_cord(x, y)
    return [x / 3, y / 3]
  end  
  
  def valid_block?(x,y)
    block_array = []
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        if block_cord(x, y) == block_cord(row_index, col_index)
          block_array << cell
        end  
      end
    end
    block_array.count(@board[x][y]) <= 1
  end
  
  def solve(board = @board)
    if board_completed?(board)
      return true
    end
    
    0.upto(8) do |x|
      0.upto(8) do |y|
        if board[x][y] == 0
          1.upto(9) do |n|
            board[x][y] = n
            if valid_row?(x) && valid_column?(y)
              if valid_block?(x, y)
                if solve(board)
                  return true
                end
              end
            end
          end
          board[x][y] = 0
          return false
        end
      end
    end
  end
  
  def board
    return @board
  end
  
  def board_completed?(board)
    result = true
    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        result = result && valid_row?(row_index) && valid_column?(col_index) && cell != 0 && valid_block?(row_index, col_index)
      end
    end
    return result
  end

  def to_s
    print_string = ""
    @board.each do |row|
      print_string += row.join("") + "\n"
    end
    print_string 
  end
end