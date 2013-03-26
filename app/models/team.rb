class Team
  attr_reader :offense, :defense, :plus_minus

  def initialize(offense, defense)
    @offense = offense
    @defense = defense
    @plus_minus = 0
  end

  def increment_plus_minus
    @plus_minus += 1
  end

  def decrement_plus_minus
    @plus_minus -= 1
  end

  def ==(other)
    offense.id == other.offense.id && defense.id == other.defense.id
  end

  def eql?(other)
    self == other
  end

  def hash
    result = 1
    result = result * 17 + offense.id
    result = result * 31 + defense.id
    result
  end
end

