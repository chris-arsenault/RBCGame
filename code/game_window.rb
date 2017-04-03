module GameWindow
  def self.top_left
    Point2D.new(x: 0, y: 0)
  end

  def self.bottom_right
    Point2D.new(x: 800, y: 600)
  end
  def self.width
    bottom_right.x - top_left.x
  end
  def self.height
    bottom_right.y - top_left.y
  end

  def self.game_to_screen(point)

  end
end