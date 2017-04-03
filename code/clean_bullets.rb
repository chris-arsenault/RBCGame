class CleanBullets

  def initialize(window)
    @window = window
  end

  def execute
    @window.game_objects.delete_if{|g| g.type == :bullet && @window.game_objects.count{|g| g.type== :bullet} > 100}
  end
end