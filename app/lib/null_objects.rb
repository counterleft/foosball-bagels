require "naught"

module NullObjects
  NullPresenter = Naught.build do |config|
    config.black_hole
    config.define_implicit_conversions
    config.define_explicit_conversions

    def to_s
      "n/a"
    end
  end
end
