class CurrentBagelOwner
  def self.fetch
    latest_bagel = Bagel.includes(:owner).order("baked_on desc, created_at desc, id desc").first
    current_owner = latest_bagel.nil? ? nil : latest_bagel.owner
    current_owner
  end
end
