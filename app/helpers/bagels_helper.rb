module BagelsHelper
  def today
    return Time.now.strftime "%m/%d/%Y"
  end
end
