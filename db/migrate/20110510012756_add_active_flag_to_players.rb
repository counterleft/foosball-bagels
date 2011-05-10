class AddActiveFlagToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :active, :boolean, :default => true
  end

  def self.down
    remove_column :players, :active
  end
end
