class BagelListPresenter < Presenter
  def initialize(bagel_list)
    super(bagel_list)
  end

  def each_bagel(&block)
    bagel_list.each do |bagel|
      presenter = BagelPresenter.new_from(bagel)
      block.call(presenter)
    end
  end

  def self.new_from(bagel_list)
    self.Maybe(BagelListPresenter.new(bagel_list))
  end
end
