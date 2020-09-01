class Snake
    attr_reader :game_over, :score, :direction
    def initialize
        @image = Gosu::Image.new("media/square.bmp") # find image
        @img = Gosu::Image.new("media/head.bmp")
        @velocity = 16
        @direction = "right"
        @body = [[0, 0]]
        @score = 0
        @beep = Gosu::Sample.new("media/eat.mp3")
    end

    def resetScore
        @score = 0
    end

    def turn(dir)
        # These if statements make sure that you cannot move left if you are already moving right and vice versa / for up and down
        if @direction == "right" && dir != "left"
            @direction = dir
        end
        if @direction == "left" && dir != "right"
            @direction = dir
        end
        if @direction == "up" && dir != "down"
            @direction = dir
        end
        if @direction == "down" && dir != "up"
            @direction = dir
        end
    end

    def move
        x = @body[0][0].to_i
        y = @body[0][1].to_i
        new_pos = []

        #Switch statement determing which direction to move the snake in
        case @direction
        when "right" then
            if (x + @velocity) < 640 
                new_pos << (x + @velocity)
                new_pos << y
            else 
                @game_over = true
            end 
        when "left" then
            if (x - @velocity >= 0)
                new_pos << (x - @velocity) 
                new_pos << y
            else
                @game_over = true
            end
        when "up" then
            if (y - @velocity >= 0 )
                new_pos << x
                new_pos << (y - @velocity) 
            else
                @game_over = true
            end
        when "down" then
            if (y + @velocity < 480)
                new_pos << x
                new_pos << (y + @velocity) 
            else
                @game_over = true
            end
        end

        #Check if the snake has hit itself
        if @body.include? new_pos
            @game_over = true
        else
            # Otherwise, add the new pos to the snake body and remove the old position unless the snake ate an apple that frame
            @body.insert(0, new_pos)
            @body.pop unless @add_square
        end
        @add_square = false
    end

    def eat(food)
        @body.each do |x, y|
          if [food.x, food.y] == [x, y] # If coordinates of snakehead and the apple match, then the snake ate the apple
            food.pos_init
            @score += 1
            @add_square = true
            @beep.play
          end
        end
      end

    def draw
        if !@game_over
            @img.draw(@body[0][0], @body[0][1],1) #draw the head
            
            @body.drop(1).each do |x, y|
                @image.draw(x,y,1)
            end
        end
    end
end