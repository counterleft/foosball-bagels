require Rails.root.join("spec/blueprints.rb")

Before do
  @brian = Player.make(name: "Brian", plus_minus: -1)
  @emre = Player.make(name: "Emre", plus_minus: 1)
  @nathan = Player.make(name: "Nathan", plus_minus: 1)
  @greg = Player.make(name: "Greg")

  Bagel.make(
    owner: @brian,
    opponent_1: @nathan,
    opponent_2: @emre,
  )
end
