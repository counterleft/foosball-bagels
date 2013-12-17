require "naught"

module NullObjects
  NullPresentee = Naught.build do |config|
    config.black_hole
    config.define_implicit_conversions
    config.define_explicit_conversions

    def to_s
      "n/a"
    end
  end

  NullObject = Naught.build do |config|
    config.black_hole
    config.define_explicit_conversions
    config.define_implicit_conversions
  end
end
