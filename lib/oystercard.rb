require './lib/journey_log'

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  PENALTY = 6

  attr_reader :balance, :entry_station, :exit_station, :list_of_journeys

  def initialize (balance = 0)
    @balance = balance
    @list_of_journeys = JourneyLog.new
  end

  def top_up amount
    raise "Over maximum balance of #{MAXIMUM_BALANCE}" if (@balance + amount) > MAXIMUM_BALANCE
    self.balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in station
    raise "balance less than minimum fare of £#{MINIMUM_BALANCE}" if balance < MINIMUM_BALANCE
    penalty if in_journey?
    self.entry_station = station
  end

  def touch_out station
    self.exit_station = station
    list_of_journeys.log = {:entry_station => entry_station, :exit_station => exit_station}
    deduct MINIMUM_BALANCE
  end

  private

  def deduct amount
    self.entry_station = nil
    self.balance -= amount
  end

  def penalty
    self.balance -= PENALTY
    self.exit_station = "You didn't touch-out!"
    list_of_journeys.log = {:entry_station => entry_station, :exit_station => exit_station}
  end

  attr_accessor :in_use
  attr_writer :balance, :entry_station, :exit_station, :list_of_journeys

end
