require "spec_helper"

describe CreateBagel do
  let(:player1) { Player.make! }
  let(:player2) { Player.make! }
  let(:player3) { Player.make! }
  let(:player4) { Player.make! }

  context "#save" do
    it "should save only if players involved are distinct" do
      actual = CreateBagel.save('2009/01/02', player1.id, player2.id, player3.id, player1.id)
      expect(actual.persisted?).to be(false)
    end

    it "should create a new bagel given valid attributes" do
      expect {
        CreateBagel.save('2009/01/02', player1.id, player2.id, player3.id, player4.id)
      }.to change { Bagel.count }.by(1)
    end

    it "should have baked_on date on save" do
      actual = CreateBagel.save(nil, player1.id, player2.id, player3.id, player4.id)
      expect(actual.persisted?).to be(false)
    end

    it "should have defensive opponent on save" do
      actual = CreateBagel.save('2009/01/02', player1.id, player2.id, player3.id, nil)
      expect(actual.persisted?).to be(false)
    end

    it "should have offensive opponent on save" do
      actual = CreateBagel.save('2009/01/02', player1.id, player2.id, nil, player4.id)
      expect(actual.persisted?).to be(false)
    end

    it "should have teammate on save" do
      actual = CreateBagel.save('2009/01/02', player1.id, nil, player3.id, player4.id)
      expect(actual.persisted?).to be(false)
    end

    it "should have owner on save" do
      actual = CreateBagel.save('2009/01/02', nil, player2.id, player3.id, player4.id)
      expect(actual.persisted?).to be(false)
    end

    it "should decrease owner's plus minus by one on save" do
      expect {
        CreateBagel.save('2009/01/02', player1.id, player2.id, player3.id, player4.id)
      }.to change { Player.find_by_id(player1.id).plus_minus }.by(-1)
    end

    it "should decrease teammate's plus minus by one on save" do
      expect {
        CreateBagel.save('2009/01/02', player1.id, player2.id, player3.id, player4.id)
      }.to change { Player.find_by_id(player2.id).plus_minus }.by(-1)
    end

    it "should increase offensive opponent's plus minus by one on save" do
      expect {
        CreateBagel.save('2009/01/02', player1.id, player2.id, player3.id, player4.id)
      }.to change { Player.find_by_id(player3.id).plus_minus }.by(1)
    end

    it "should increase defensive opponent's plus minus by one on save" do
      expect {
        CreateBagel.save('2009/01/02', player1.id, player2.id, player3.id, player4.id)
      }.to change { Player.find_by_id(player4.id).plus_minus }.by(1)
    end

  end
end
