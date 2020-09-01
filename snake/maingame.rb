require_relative 'snake'
require_relative 'snake2'
require_relative 'apple'
require 'gosu'


class Tutorial < Gosu::Window
    def initialize
        super 640, 480, false, 60
        self.caption = "Snake Game"
        @player = Snake.new
        @twoplayeron = false
        @apple = Apple.new
        @font = Gosu::Font.new(20)
        @background_image = Gosu::Image.new("media/bg.png", :tileable => true)
        @dead = Gosu::Sample.new("media/die.mp3")
    end

    
    # Gets called once every frame 
    def update
        if !@player.game_over 
            if Gosu.button_down? Gosu::KB_LEFT
                @player.turn("left")
            end 
            if Gosu.button_down? Gosu::KB_RIGHT
                @player.turn("right")
            end
            if Gosu.button_down? Gosu::KB_UP
                @player.turn("up")
            end
            if Gosu.button_down? Gosu::KB_DOWN
                @player.turn("down")
            end
            if @twoplayeron 
                if !@player2.game_over
                    if Gosu.button_down? Gosu::KB_A
                        @player2.turn("left")
                    end 
                    if Gosu.button_down? Gosu::KB_D
                        @player2.turn("right")
                    end
                    if Gosu.button_down? Gosu::KB_W
                        @player2.turn("up")
                    end
                    if Gosu.button_down? Gosu::KB_S
                        @player2.turn("down")
                    end
                end
            end
            if Gosu.button_down? Gosu::KB_T
                @player.resetScore
                @player = Snake.new
                @player2 = Snake2.new
                @player2.resetScore
                @twoplayeron = true
                @player2.game_over = false
            end
        else 
            if Gosu.button_down? Gosu::KB_SPACE
                @player.resetScore
                @player = Snake.new
                @dead.play
            end
        end
        @player.eat(@apple)
        @player.move
        if @twoplayeron
            @player2.eat(@apple)
            @player2.move
        end
        
    end

    def draw
        @background_image.draw(0,0,0)
        @player.draw
        if @twoplayeron
            @player2.draw
            @font.draw_text("P2 Score: #{@player2.score}", 530, 10, 0)
            if @player2.game_over
                @font.draw_text("Player 1 wins, hit T to restart", 200, 10, 0)
            end
            if @player.game_over    
                @font.draw_text("Player 2 wins, hit T to restart", 200, 10, 0)
                return
            end
        end
        @font.draw_text("Press T to play multiplayer", 220, 440, 0)
        @apple.draw
        @font.draw_text("P1 Score: #{@player.score}", 10, 10, 0)
        if @player.game_over && !@twoplayeron
            @font.draw_text("Press Space to restart", 220, 250, 0)

        end
    end

    def button_down(id)
        if id== Gosu::KB_ESCAPE
            close
        else
            super
        end
    end
end


Tutorial.new.show