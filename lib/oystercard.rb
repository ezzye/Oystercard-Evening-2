class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :entry_station, :exit_station, :list_of_journeys

  def initialize (balance = 0)
    @balance = balance
    @in_use = false
    @entry_station = nil
    @exit_station = nil
    @list_of_journeys = []
  end

  def top_up amount
    raise "Over maximum balance of #{MAXIMUM_BALANCE}" if (@balance + amount) > MAXIMUM_BALANCE
    self.balance += amount
  end

  def in_journey?
    entry_station
  end

  def touch_in station
    raise "balance less than minimum fare of £#{MINIMUM_BALANCE}" if balance < MINIMUM_BALANCE
    self.entry_station = station
  end

  def touch_out station
    self.exit_station = station
    self.list_of_journeys << {:entry_station => entry_station, :exit_station => exit_station}
    self.entry_station = nil
    deduct MINIMUM_BALANCE
  end

  private

  def deduct amount
    self.balance -= amount
  end

  attr_accessor :in_use
  attr_writer :balance, :entry_station, :exit_station, :list_of_journeys

end
