require 'gosu'
Dir['./code/*.rb'].each {|file| require file }

class RBCGame < Gosu::Window
  attr_accessor :gravity

  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "Book Club Game"
    @art = Art.new(self)
    @sprite = UserSprite.new(self)


    @bullets = []
    @gravity = 0.5
    @G = -0.04
    @id = 0
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def update
    @sprite.update
    if button_down? Gosu::KB_SPACE
      new_bullet = BulletSprite.new(self)
      new_bullet.x = @sprite.x
      new_bullet.y = @sprite.y
      new_bullet.id = @id
      @id += 1
      new_bullet.vx = case @sprite.direction
                        when :left
                          -30
                        when :right
                          30
                        else
                          0
                      end
      new_bullet.vy = case @sprite.direction
                        when :down
                          -1
                        when :up
                          1
                        else
                          0
                      end
      @bullets <<  new_bullet
    end

    @bullets.delete_if{ |b| b.off_screen}
    @bullets.delete_at(0) while @bullets.count >= 50

    @bullets.each do |b|
      b.update
    end

    #gravity
    @bullets.each do |b1|
      @bullets.each do |b2|
        next if b1 == b2
        collide(b1, b2)
        force = gravityForce(b1, b2)
        b1.vx += force[0]
        b1.vy += force[1]
        # while collide(b1, b2)
        #   b1.x += b1.vx / b1.vx.abs
        #   b1.y += b1.vy / b1.vy.abs
        # end
      end
      force = gravityForce(b1, @sprite)
      b1.vx += force[0]
      b1.vy += force[1]
    end
  end

  def gravityForce(a, b)
    dx = a.center_x - b.center_x
    dy = a.center_y - b.center_y
    r = Math.sqrt((dx)**2 + (dy)**2)
    force = @G*((a.mass * b.mass)/r*r)
    [force * dx/r, force * dy/r]
  end

  def collide(a, b)
    dx = (a.center_x - b.center_x).abs - a.radius/2
    dy = (a.center_y - b.center_y).abs - a.radius/2

    d = 0.5
    collide = (dx < d && dy < d)
    if collide
      a.vx = -a.vx
      a.vy = -a.vy
      b.vx = -b.vx
      b.vy = -b.vy
      a.x -= dx
      a.y -= dy
    end
    collide
  end

  def draw
    @sprite.draw

    @bullets.each do |b|
      b.draw
    end
  end
end

RBCGame.new.show
