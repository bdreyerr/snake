class Apple
    attr_accessor :x, :y
    def initialize
        @image = Gosu::Image.new("media/apple.bmp")
        pos_init
    end

    def pos_init
        @x = (1...40).to_a.sample * 16
        @y = (1...30).to_a.sample * 16
    end

    def draw
        @image.draw(@x, @y, 1)
    end
end