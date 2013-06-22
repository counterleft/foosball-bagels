require Rails.root.join("spec/blueprints.rb")

Before do
  @brian = Player.make(name: "Brian", plus_minus: -1)
  @emre = Player.make(name: "Emre", plus_minus: 1)
  @nathan = Player.make(name: "Nathan", plus_minus: 1)
  @greg = Player.make(name: "Greg", plus_minus: -1)

  Bagel.make(
    owner: @brian,
    teammate: @greg,
    opponent_1: @nathan,
    opponent_2: @emre,
  )
end
