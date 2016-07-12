require_relative "plane"
require_relative "weather"

class Airport
  attr_reader :planes, :weather, :capacity

  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY)
    @planes = []
    @weather = Weather.new
    @capacity = capacity
  end


  def land(plane)
    fail "Plane has already landed" if flying?(plane)
    fail "Weather is bad, plane cannot land" if weather.stormy?
    fail "Airport is full" if full?
    plane.land_plane
    planes.push(plane)
  end

  def take_off(plane)
    fail "No planes" unless find(plane)
    fail "Weather is bad, plane cannot take off" if weather.stormy?
    plane.fly
    remove(plane)
  end

  #private

  def flying?(plane)
    plane.landed?
  end

  def find(plane)
    planes.include?(plane)
  end

  def remove(plane)
    planes.delete(plane)
  end

  def full?
    planes.count == @capacity
  end

end
