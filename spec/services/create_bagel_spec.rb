require "spec_helper"

describe CreateBagel do
  let(:player1) { Player.make }
  let(:player2) { Player.make }
  let(:player3) { Player.make }
  let(:player4) { Player.make }

  context "#save" do
    it "should save only if players involved are distinct" do
      subject = CreateBagel.new('2009/01/02', player1.name, player2.name, player3.name, player1.name)
      actual = subject.save
      expect(actual.persisted?).to be_false
    end

    it "should create a new bagel given valid attributes" do
      subject = CreateBagel.new('2009/01/02', player1.name, player2.name, player3.name, player4.name)
      expect { subject.save }.to change { Bagel.count }.by(1)
    end

    it "should have baked_on date on save" do
      subject = CreateBagel.new(nil, player1.name, player2.name, player3.name, player4.name)
      actual = subject.save
      expect(actual.persisted?).to be_false
    end

    it "should have defensive opponent on save" do
      subject = CreateBagel.new('2009/01/02', player1.name, player2.name, player3.name, nil)
      actual = subject.save
      expect(actual.persisted?).to be_false
    end

    it "should have offensive opponent on save" do
      subject = CreateBagel.new('2009/01/02', player1.name, player2.name, nil, player4.name)
      actual = subject.save
      expect(actual.persisted?).to be_false
    end

    it "should have teammate on save" do
      subject = CreateBagel.new('2009/01/02', player1.name, nil, player3.name, player4.name)
      actual = subject.save
      expect(actual.persisted?).to be_false
    end

    it "should have owner on save" do
      subject = CreateBagel.new('2009/01/02', nil, player2.name, player3.name, player4.name)
      actual = subject.save
      expect(actual.persisted?).to be_false
    end

    it "should decrease owner's plus minus by one on save" do
      subject = CreateBagel.new('2009/01/02', player1.name, player2.name, player3.name, player4.name)
      expect { subject.save }.to change { Player.find_by_id(player1.id).plus_minus }.by(-1)
    end

    it "should decrease teammate's plus minus by one on save" do
      subject = CreateBagel.new('2009/01/02', player1.name, player2.name, player3.name, player4.name)
      expect { subject.save }.to change { Player.find_by_id(player2.id).plus_minus }.by(-1)
    end

    it "should increase offensive opponent's plus minus by one on save" do
      subject = CreateBagel.new('2009/01/02', player1.name, player2.name, player3.name, player4.name)
      expect { subject.save }.to change { Player.find_by_id(player3.id).plus_minus }.by(1)
    end

    it "should increase defensive opponent's plus minus by one on save" do
      subject = CreateBagel.new('2009/01/02', player1.name, player2.name, player3.name, player4.name)
      expect { subject.save }.to change { Player.find_by_id(player4.id).plus_minus }.by(1)
    end

  end
end
