class AddSurnameToPlayers < ActiveRecord::Migration
  class Player < ActiveRecord::Base
    # Faux model that keeps rails from running migrations
    # Useful when you mess with models in migrations
    # See http://guides.rubyonrails.org/v3.2.13/migrations.html#using-models-in-your-migrations
  end

  def change
    add_column(:players, :surname, :string)

    Player.reset_column_information

    # Update the only player that has a duplicate first name
    chris_rael = Player.where("name = 'Chris'").first
    if chris_rael
      chris_rael.surname = "Rael"
      chris_rael.save!
    end
  end
end
