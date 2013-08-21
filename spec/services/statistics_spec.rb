require "spec_helper"

describe Statistics do
  context ".index_page_report" do
    let(:subject) { Statistics.index_report }

    context "no bagels given ever" do
      it "provides sensible report values" do
        expect(subject.current_bagel_owner).to be_nil
        expect(subject.best_team).to be_nil
        expect(subject.worst_team).to be_nil
        expect(subject.total_bagel_count).to eq(0)
        expect(subject.players_grouped_by_bagel_ownage).to be_empty
        expect(subject.bagels_given_over_time).to be_empty
        expect(subject.players_by_plus_minus).to be_empty
      end
    end

    context "bagels have been given" do
      before(:each) do
        @player = Player.make
        @bagel = Bagel.make(baked_on: "3000/12/12", owner: @player)
      end

      it "has the current bagel owner" do
        expect(subject.current_bagel_owner).to eq(@player)
      end

      it "has players grouped by bagels owned" do
        expect(subject.players_grouped_by_bagel_ownage).to eq(
          { @player.name => 1 }
        )
      end

      it "all bagels given" do
        expect(subject.bagels_given_over_time).to have(1).items
        expect(subject.total_bagel_count).to eq(Bagel.count)
      end

      it "has the best team" do
        expect(subject.best_team.offense_name).to eq(@bagel.opponent_1.name)
        expect(subject.best_team.defense_name).to eq(@bagel.opponent_2.name)
      end

      it "has the worst team" do
        expect(subject.worst_team.offense_name).to eq(@bagel.teammate.name)
        expect(subject.worst_team.defense_name).to eq(@bagel.owner.name)
      end
    end

    context "bagels with inactive players" do
      it "cannot be the best team" do
        @inactive = Player.make(active: false)
        Bagel.make(owner: @inactive)

        expect(subject.best_team).to be_nil
      end
    end
  end
end
