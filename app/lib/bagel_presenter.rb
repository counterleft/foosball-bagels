class BagelPresenter < Presenter
  attr_reader :owner, :teammate, :opponent_1, :opponent_2

  def initialize(bagel)
    super(bagel)

    @owner = PlayerPresenter.new(bagel.owner)
    @teammate = PlayerPresenter.new(bagel.teammate)
    @opponent_1 = PlayerPresenter.new(bagel.opponent_1)
    @opponent_2 = PlayerPresenter.new(bagel.opponent_2)
  end
end
