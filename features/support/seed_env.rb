require Rails.root.join("spec/blueprints.rb")

Before do
  @brian = Player.make(name: "Brian")
  @emre = Player.make(name: "Emre")
  @nathan = Player.make(name: "Nathan")
  @greg = Player.make(name: "Greg")

  # brian is bagel owner
  CreateBagel.save("2012-01-02", @brian.id, @greg.id, @nathan.id, @emre.id)

  # emre in each position
  CreateBagel.save("2012-01-01", @emre.id, @greg.id, @nathan.id, @brian.id)
  CreateBagel.save("2012-01-01", @brian.id, @emre.id, @nathan.id, @greg.id)
  CreateBagel.save("2012-01-01", @brian.id, @greg.id, @emre.id, @nathan.id)
  CreateBagel.save("2012-01-01", @brian.id, @greg.id, @nathan.id, @emre.id)

  # enough bagels for pagination to kick in
  10.times.each do
    CreateBagel.save("2012-01-01", @brian.id, @greg.id, @nathan.id, @emre.id)
  end

end
