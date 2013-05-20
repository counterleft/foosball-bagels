require "ostruct"

class Statistics
  def self.index_report
    report = OpenStruct.new
    report.current_bagel_owner = CurrentBagelOwner.fetch
    report
  end
end
