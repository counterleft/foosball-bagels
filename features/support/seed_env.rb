require Rails.root.join("spec/blueprints.rb")

Before do
  brian = Player.make(name: "Brian")
  emre = Player.make(name: "Emre")
  nathan = Player.make(name: "Nathan")
  Bagel.make(
    owner: brian,
    opponent_1: nathan,
    opponent_2: emre,
  )
end
