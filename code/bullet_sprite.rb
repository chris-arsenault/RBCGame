class BulletSprite < GameObject
  def type
    :bullet
  end
  def obeys_gravity?
    true
  end

  def obeys_friction?
    true
  end

  def gravity_attracts?
    true
  end

  def collides?
    true
  end

  def has_animation?
    false
  end

  def draw_trajectory?
    true
  end
  def mass
    1.5
  end

  def radius
    160/5
  end

  def scale
    0.2
  end

  def drawable?
    true
  end

  def sprite
    Art.instance.bullet_sprite
  end

  def post_update
    # @x = radius/2 if x > 800
    # @x = 800 - radius/2 if y < 0
    #
    # @y = radius/2 if y < 0
    # @vy = -1 * @vy.abs * @bounce if center_y >= 550
    # @y = 600 - @radius/2 if center_y >= 600
  end
end
