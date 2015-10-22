class Journey

  attr_reader :entry, :complete, :zone
  attr_writer :complete

  def initialize entry
  @entry = entry
  @complete = false
  end

  def exit= station
    @exit = station
    self.complete = true
  end

  def exit
    @exit
  end

  def fare
    (entry.zone - exit.zone).abs * 2
  end

end