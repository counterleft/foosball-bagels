class AddBakedOnDateToBagel < ActiveRecord::Migration
  def self.up
  	add_column :bagels, :baked_on, :datetime
  end

  def self.down
  	remove_column :bagels, :baked_on
  end
end

