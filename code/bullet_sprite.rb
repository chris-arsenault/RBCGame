class BulletSprite
  attr_accessor :vx, :vy, :x, :y, :mass, :radius, :id

  def initialize window
    @window = window
    # image
    @width = @height = 160
    @idle = Art.instance.bullet_sprite

    # direction and movement
    @direction = :right
    @frame = 0
    @bounce = 0.85
    @friction = 0.99
    @moving = false
    @mass = 1.5
    @radius = 160/5
  end

  def update
    @frame += 1
    @frame = @frame % @idle.size
    @x += @vx
    @y += @vy
    @vy += @window.gravity
    @vx *= @friction

    @x = @radius/2 if center_x > 800
    @x = 800 -@radius/2 if center_x < 0

    @y = @radius/2 if center_y < 0
    @vy = -1 * @vy.abs * @bounce if center_y >= 550
    @y = 600 - @radius/2 if center_y >= 600
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
    image = @idle[0]
    @scale = 1 + Random.rand(1)
    image.draw @x, @y, 1, 0.2, 0.2
    @window.draw_line(center_x, center_y, Gosu::Color.argb(0xff_ff0000), center_x + @vx*15, center_y + @vy*15, Gosu::Color.argb(0xff_ff0000), z = 0, mode = :default)
  end

  def off_screen
    # @x < 0  #|| @y < 0 || @x > 600 || @y > 400
    #@vy < 1
    @x.to_s == 'NaN'
  end

end
