module Conversions
  extend NullObjects::NullObject::Conversions

  def self.Present(presentee)
    presentee ? presentee : NullObjects::NullPresentee.new
  end
end
