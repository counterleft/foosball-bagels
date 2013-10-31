class BagelListPresenter < SimpleDelegator
  alias_method :bagels, :__getobj__

  def initialize(bagels)
    super(bagels)
  end

  def each_bagel(&block)
    bagels.each do |bagel|
      presenter = BagelPresenter.new(bagel)
      block.call(presenter)
    end
  end
end
