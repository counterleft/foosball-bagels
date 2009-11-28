class AddSaneDefaultToPlayerPlusMinus < ActiveRecord::Migration
  def self.up
    change_column :players, :plus_minus, :integer, { :default => 0, :null => false }
  end

  def self.down
    change_column :players, :plus_minus, :integer, { :null => true, :default => nil }
  end
end
