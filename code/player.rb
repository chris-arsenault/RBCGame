class Player < GameObject
  attr_accessor :direction

  def type
    :player
  end
  def obeys_gravity?
    false
  end

  def obeys_friction?
    false
  end

  def gravity_attracts?
    false
  end

  def has_animation?
    true
  end

  def draw_trajectory?

  end
  def mass
    10
  end

  def radius
    160*scale
  end

  def scale
    0.3
  end

  def drawable?
    true
  end

  def sprite
    Art.instance.player_moving
  end

  def post_initialize
    @direction = :right
  end

  def post_update
    if @window.button_down? Gosu::KbLeft
      @direction = :left
      @pos.x -= 5
    end
    if @window.button_down? Gosu::KbRight
      @direction = :right
      @pos.x += 5
    end
    if @window.button_down? Gosu::KbUp
      @direction = :up
      @pos.y -= 5
    end
    if @window.button_down? Gosu::KbDown
      @direction = :down
      @pos.y += 5
    end
  end
end
