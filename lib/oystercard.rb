require './lib/journey_log'
require './lib/journey'

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  PENALTY = 6

  attr_reader :balance, :entry_station, :exit_station, :list_of_journeys, :journey

  def initialize (balance = 0)
    @balance = balance
    @list_of_journeys = JourneyLog.new
  end

  def top_up amount
    raise "Over maximum balance of #{MAXIMUM_BALANCE}" if (@balance + amount) > MAXIMUM_BALANCE
    self.balance += amount
  end

  def in_journey?
    # !!entry_station
    journey.complete
  end

  def touch_in station
    raise "balance less than minimum fare of £#{MINIMUM_BALANCE}" if balance < MINIMUM_BALANCE
    # self.entry_station = station
    @journey = Journey.new station
    penalty if in_journey?
  end

  def touch_out station
    # self.exit_station = station
    journey.exit = station
    # list_of_journeys.log = {:entry_station => entry_station, :exit_station => exit_station}
    list_of_journeys.log = journey
    # deduct MINIMUM_BALANCE
    deduct
  end

  private

  def deduct
    # self.entry_station = nil
    journey.complete
    self.balance -= journey.fare
  end

  def penalty
    self.balance -= PENALTY
    # self.exit_station = "You didn't touch-out!"
    journey.exit = "You didn't touch-out!"
    # list_of_journeys.log = {:entry_station => entry_station, :exit_station => exit_station}
    list_of_journeys.log = journey
  end

  attr_accessor :in_use
  attr_writer :balance, :entry_station, :exit_station, :list_of_journeys

end
