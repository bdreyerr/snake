require_relative 'snake'

# This class is instanciated as the second player during multiplayer, difference are different colored head and different starting position
class Snake2 < Snake
    attr_reader :game_over, :score, :direction
    attr_accessor :game_over
    def initialize
        @image = Gosu::Image.new("media/square.bmp") # find image
        @img = Gosu::Image.new("media/p2.bmp")
        @velocity = 16
        @direction = "left"
        @body = [[640, 0]]
        @score = 0
        @beep = Gosu::Sample.new("media/eat.mp3")
    end
end