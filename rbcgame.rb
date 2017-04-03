require 'gosu'
require 'require_all'
require_all 'code'
# Dir['./code/*.rb'].each {|file| require file }

class RBCGame < Gosu::Window
  attr_accessor :game_objects

  def initialize(width=800, height=600, fullscreen=false)
    super
    self.caption = 'Book Club Game'
    @art = Art.new(self)
    @song = Gosu::Song.new('./music/battle.mp3')
    @song.play(true)

    @camera = GameCamera.new
    @game_objects = [Player.new(window: self, x: 400, y: 300)]

    @interactions = []
    register_interaction FireBullets
    register_interaction CleanBullets
  end
  def player
    @game_objects[0]
  end

  def register_interaction(klass)
    @interactions << klass.new(self)
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def update
    @game_objects.each do |g|
      g.update
    end

    @interactions.each do |i|
      i.execute
    end
  end

  def draw
    @game_objects.each do |b|
      b.draw
    end
  end
end

RBCGame.new.show
