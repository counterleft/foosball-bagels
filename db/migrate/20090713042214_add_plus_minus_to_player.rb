class AddPlusMinusToPlayer < ActiveRecord::Migration
  def self.up
  	add_column :players, :plus_minus, :integer
  end

  def self.down
  	remove_column :players, :plus_minus, :integer
  end
end

