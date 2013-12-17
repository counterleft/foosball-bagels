class BagelListPresenter < Presenter
  def each_bagel(&block)
    wrapped_enum(BagelPresenter, bagel_list, &block)
  end
end
