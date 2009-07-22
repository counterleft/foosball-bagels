class CreateBagels < ActiveRecord::Migration
  def self.up
    create_table :bagels do |t|
      t.datetime :created
      t.references :owner, :class_name => 'Player'
      t.references :teammate, :class_name => 'Player'
      t.references :opponent_1, :class_name => 'Player'
      t.references :opponent_2, :class_name => 'Player'

      t.timestamps
    end
  end

  def self.down
    drop_table :bagels
  end
end

