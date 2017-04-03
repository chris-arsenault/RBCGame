module Physics
  GRAVITY = -0.5
  G = 0.04
  AIR_FRICTION = 0.99
  E = 0.1

  def self.gravity_force(a, b)
    dx = a.pos.x - b.pos.x
    dy = a.pos.y - b.pos.y
    return if dx < E && dy < E
    r = Math.sqrt((dx)**2 + (dy)**2)
    force = G*((a.mass * b.mass)/r*r)

    a.vel.x -= force * dx/r
    a.vel.y -= force * dy/r
  end

  def self.collide(a, b)
    dx = (a.pos.x - b.pos.x).abs - a.radius/2
    dy = (a.pos.y - b.pos.y).abs - a.radius/2

    d = 0.5
    collide = (dx < d && dy < d)
    if collide
      a.vel.x = -a.vel.x
      a.vel.y = -a.vel.y
      b.vel.x = -b.vel.x
      b.vel.y = -b.vel.y
      a.pos.x -= dx
      a.pos.y -= dy
    end
    collide
  end
end