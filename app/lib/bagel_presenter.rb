class BagelPresenter < Presenter
  attr_reader :owner, :teammate, :opponent_1, :opponent_2

  def initialize(bagel)
    super(bagel)

    @owner = PlayerPresenter.new_from(bagel.owner)
    @teammate = PlayerPresenter.new_from(bagel.teammate)
    @opponent_1 = PlayerPresenter.new_from(bagel.opponent_1)
    @opponent_2 = PlayerPresenter.new_from(bagel.opponent_2)
  end
end
