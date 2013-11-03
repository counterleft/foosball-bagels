require "naught"

module NullObjects
  NullObjectPresenter = Naught.build do |config|
    config.black_hole
    config.define_implicit_conversions
    config.define_explicit_conversions

    def initialize(*args)
    end

    def to_s
      "n/a"
    end
  end

  NullObject = Naught.build do |config|
    config.black_hole
    config.define_explicit_conversions
    config.traceable
  end

  class EmptyListPresenter < SimpleDelegator
    def initialize(*args)
      super([])
    end

    def total_pages
      0
    end

    def method_missing(m, *args, &block)
      if m.to_s.starts_with?("each_")
        []
      else
        super
      end
    end
  end

  NullObjectListPresenter = EmptyListPresenter
end
