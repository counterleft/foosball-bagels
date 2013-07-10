require Rails.root.join("spec/blueprints.rb")

Before do
  @brian = Player.make(name: "Brian")
  @emre = Player.make(name: "Emre")
  @nathan = Player.make(name: "Nathan")
  @greg = Player.make(name: "Greg")

  # brian is bagel owner
  CreateBagel.save("2012-01-02", @brian.name, @greg.name, @nathan.name, @emre.name)

  # emre in each position
  CreateBagel.save("2012-01-01", @emre.name, @greg.name, @nathan.name, @brian.name)
  CreateBagel.save("2012-01-01", @brian.name, @emre.name, @nathan.name, @greg.name)
  CreateBagel.save("2012-01-01", @brian.name, @greg.name, @emre.name, @nathan.name)
  CreateBagel.save("2012-01-01", @brian.name, @greg.name, @nathan.name, @emre.name)

end
