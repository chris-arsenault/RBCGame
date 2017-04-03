class FireBullets
  def initialize(window)
    @window = window
    @last_fire = Time.now
  end

  def execute
    if @window.button_down? Gosu::KB_SPACE

      return unless Time.now - @last_fire > 0.2
      @last_fire = Time.now

      new_bullet = BulletSprite.new(window: @window)
      new_bullet.pos = @window.player.pos.clone
      new_bullet.vel.x = case @window.player.direction
                        when :left
                          -30
                        when :right
                          30
                        else
                          0
                      end
      new_bullet.vel.y = case @window.player.direction
                        when :down
                          -1
                        when :up
                          1
                        else
                          0
                         end
      @window.game_objects <<  new_bullet
    end
  end
end