class Art
  def initialize(window)
    @window = window
    @@instance = self
  end

  def self.instance
    @@instance
  end

  def background

  end

  def player_idle
    @idle ||= Gosu::Image.load_tiles @window,
                                     "art/player_160x160_idle.png",
                                     160, 160, true

  end

  def player_moving
    @move ||= Gosu::Image.load_tiles @window,
                                   "art/player_160x160_move.png",
                                   160, 160, true
  end

  def bullet_sprite
    @move ||= Gosu::Image.load_tiles @window,
                                     "art/player_160x160_move.png",
                                     160, 160, true
  end
end