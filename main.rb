require 'matrix'
require 'byebug'

class Minesweeper
  attr_accessor :width, :height, :num_mines, :matrix, :still_playing

  def initialize(width, height, num_mines)
    @width = width
    @height = height
    @num_mines = num_mines
    @still_playing = false
    @matrix = build_matrix
    insert(bomb_coordinates)
  end

  def build_matrix
    matrix = []

    @width.times do
      matrix.push(Array.new(@height, '.'))
    end

    matrix
  end

  def bomb_coordinates
    coordinates = []

    @num_mines.times do
      coordinate = { width: rand(@width), height: rand(@height) }

      if !coordinates.include?(coordinate) || coordinates.empty?
        coordinates.push(coordinate)
      end
    end

    coordinates
  end

  def insert(bomb_coordinates)
    bomb_coordinates.each do |bomb_coordinate|
      @matrix[bomb_coordinate[:width]][bomb_coordinate[:height]] = '#'
    end
  end

  def still_playing?
    @still_playing
  end

  def play(x, y)
    if @matrix[x][y] == '.'
      @matrix[x][y] = ''
      check_arround_cells(x, y)
    end
  end

  def check_arround_cells(x, y)
    # 1° siperior esquerda
    if x == 0 && y == 0
      if @matrix[x + 1][y] == '.' && @matrix[x][y + 1] == '.' && @matrix[x + 1][y + 1] == '.'
        @matrix[x + 1][y] = ''
        @matrix[x][y + 1] = ''
        @matrix[x + 1][y + 1] = ''
      end
    # 2° superior direita
    elsif x == @width - 1 && y == 0
      if @matrix[x - 1][y] == '.' && @matrix[x][y + 1] == '.' && @matrix[x - 1][y + 1]
        @matrix[x - 1][y] = ''
        @matrix[x][y + 1] = ''
        @matrix[x - 1][y + 1] = ''
      end
    # 3° inferior esquerda
    elsif x == 0 && y == @height - 1
      if @matrix[x][y - 1] == '.' && @matrix[x + 1][y] == '.' && @matrix[x + 1][y - 1] == '.'
        @matrix[x][y - 1] = ''
        @matrix[x + 1][y] = ''
        @matrix[x + 1][y - 1] = ''
      end
    # 4° inferior direita
    elsif x == @width - 1 && y == @height - 1
      if @matrix[x - 1][y] == '.' && @matrix[x][y - 1] == '.' && @matrix[x - 1][y - 1] == '.'
        @matrix[x - 1][y] = ''
        @matrix[x][y - 1] = ''
        @matrix[x - 1][y - 1] = ''
      end
    elsif x == 0
      if @matrix[x][y - 1] == '.' && @matrix[x + 1][y - 1] == '.' && @matrix[x + 1][y] == '.' && @matrix[x + 1][y + 1] == '.' && @matrix[x][y + 1] == '.'
        @matrix[x][y - 1] = ''
        @matrix[x + 1][y - 1] = ''
        @matrix[x + 1][y] = ''
        @matrix[x + 1][y + 1] = ''
        @matrix[x][y + 1] = ''
      end
    elsif y == 0
      if @matrix[x-1][y] == '.' && @matrix[x - 1][y + 1] == '.' && @matrix[x][y + 1] == '.' && @matrix[x + 1][y + 1] == '.' && @matrix[x + 1][y] == '.'
        @matrix[x-1][y] = ''
        @matrix[x - 1][y + 1] = ''
        @matrix[x][y + 1] = ''
        @matrix[x + 1][y + 1] = ''
        @matrix[x + 1][y] = ''
      end
    elsif x == @width - 1
      if @matrix[x][y - 1] == '.' && @matrix[x - 1][y - 1] == '.' && @matrix[x - 1][y] == '.' && @matrix[x + 1][y + 1] == '.' && @matrix[x][y + 1] == '.'
        @matrix[x][y - 1] = ''
        @matrix[x - 1][y - 1] = ''
        @matrix[x - 1][y] = ''
        @matrix[x + 1][y + 1] = ''
        @matrix[x][y + 1] = ''
      end
    elsif y == @height - 1
      if @matrix[x - 1][y] == '.' && @matrix[x - 1][y - 1] == '.' && @matrix[x][y - 1] == '.' && @matrix[x + 1][y + 1] == '.' && @matrix[x + 1][y] == '.'
        @matrix[x - 1][y] = ''
        @matrix[x - 1][y - 1] = ''
        @matrix[x][y - 1] = ''
        @matrix[x + 1][y + 1] = ''
        @matrix[x + 1][y] = ''
      end
    end
  end
end

width = 4
height = 4
num_mines = 0
game = Minesweeper.new(width, height, num_mines)

game.play(0, 0)
game.play(0, 3)
game.play(3, 0)
game.play(3, 3)

game.matrix.each do |line|
  print line
  puts
end

# while !game.still_playing?
#   valid_move = game.play(0, 0)
#   valid_flag = game.flag(rand(width), rand(height))

#   if valid_move or valid_flag
#     printer = (rand > 0.5) ? SimplePrinter.new : PrettyPrinter.new
#     printer.print(game.board_stat e(
#   end
# end

# puts "Fim do jogo!"
# if game.victory?
#   puts "Você venceu!"
# else
#   puts "Você perdeu! As minas eram:"
#   PrettyPrinter.new.print(game.board_state(xray: true))
# end
