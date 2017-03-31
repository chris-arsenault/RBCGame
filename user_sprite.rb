class UserSprite
  attr_accessor :vx, :vy, :x, :y, :direction, :mass, :radius

  def initialize window
    @window = window
    # image
    @width = @height = 160
    @idle = Gosu::Image.load_tiles @window,
                                   "player_160x160_idle.png",
                                   @width, @height, true
    @move = Gosu::Image.load_tiles @window,
                                   "player_160x160_move.png",
                                   @width, @height, true
    # center image
    @x = @window.width/2  - @width/2
    @y = @window.height/2 - @height/2
    # direction and movement
    @direction = :right
    @frame = 0
    @moving = false
    @bullets = []
    @mass = 5
    @radius = 160
  end

  def update
    @frame += 1
    @frame = @frame % @idle.size
    @moving = false
    if @window.button_down? Gosu::KbLeft
      @direction = :left
      @moving = true
      @x -= 5
    end
    if @window.button_down? Gosu::KbRight
      @direction = :right
      @moving = true
      @x += 5
    end
    if @window.button_down? Gosu::KbUp
      @direction = :up
      @moving = true
      @y -= 5
    end
    if @window.button_down? Gosu::KbDown
      @direction = :down
      @moving = true
      @y += 5
    end

    @x = 800 if @x < 0
    @y = 600 if @y < 0
    @x = 0 if @x > 800
    @y = 0 if @y > 600
  end

  def center_x
    @x + @radius/2
  end

  def center_y
    @y + @radius/2
  end

  def draw
    # @move and @idle are the same size,
    # so we can use the same frame calc.
    f = @frame
    image = @moving ? @move[f] : @idle[f]
    if @direction == :right
      image.draw @x, @y, 1
    else
      image.draw @x + @width, @y, 1, -1, 1
    end
  end
end
