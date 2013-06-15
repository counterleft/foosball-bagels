require Rails.root.join("spec/blueprints.rb")

Before do
  brian = Player.make(name: "Brian")
  Bagel.make(owner: brian)
end
