class RemoveCreated < ActiveRecord::Migration
  def self.up
  	remove_column :bagels, :created
  end

  def self.down
  	add_column :bagels, :created, :datetime
  end
end

