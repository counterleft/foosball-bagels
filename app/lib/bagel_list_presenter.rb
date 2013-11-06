class BagelListPresenter < Presenter
  def each_bagel(&block)
    bagel_list.each do |bagel|
      presenter = BagelPresenter.new(bagel)
      block.call(presenter)
    end
  end
end
