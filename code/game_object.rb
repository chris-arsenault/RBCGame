class GameObject
  attr_accessor :pos, :vel, :id

  def obeys_gravity?
    false
  end

  def obeys_friction?
    false
  end

  def gravity_attracts?
    false
  end

  def collides?
    false
  end

  def has_animation?
    false
  end

  def draw_trajectory?
    false
  end
  def mass
    1
  end

  def radius
    1
  end

  def scale
    1
  end

  def drawable?
    false
  end

  def sprite
    nil
  end

  def bounce
    0.85
  end

  def post_initialize
  end

  def initialize(window: nil, x: 0, y:  0, vx: 0, vy: 0)
    @window = window
    @frame = 0
    @pos = Point2D.new(x: x, y: y)
    @vel = Point2D.new(x: vx, y: vy)

    post_initialize
  end

  def post_update

  end

  def update
    @frame += 1 if has_animation?
    @frame = @frame % sprite.size
    @pos.x += @vel.x
    @pos.y += @vel.y
    @vel.y -= Physics::GRAVITY if obeys_gravity?
    @vel.x *= Physics::AIR_FRICTION if obeys_friction?

    apply_bounds
    apply_forces


    post_update
  end

  def draw
    return unless drawable?

    image = sprite[@frame]
    image.draw @pos.x - radius, @pos.y - radius, 1, scale, scale
    if draw_trajectory?
      magnitude_multipler = 15
      red = Gosu::Color.argb(0xff_ff0000)
      @window.draw_line(@pos.x, @pos.y, red,
                        @pos.x + @vel.x*magnitude_multipler, @pos.y + @vel.y*magnitude_multipler, red,
                        z = 0, mode = :default)
    end
  end
  def apply_bounds
    @pos.x = 0 if @pos.x > GameWindow::width
    @pos.x = GameWindow::width if @pos.x < 0

    @pos.y = 0 if @pos.y < 0
    @vel.y = -1 * @vel.y.abs * bounce if @pos.y >= GameWindow::height
    @pos.y = GameWindow::height if @pos.y >= 600
  end

  def apply_forces
    @window.game_objects.each do |b2|
      next if self == b2
      Physics::gravity_force(self, b2) if gravity_attracts?
      Physics::collide(self, b2) if collides?
    end
  end
end