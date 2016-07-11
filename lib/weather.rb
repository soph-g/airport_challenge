class Weather
  attr_reader :stormy

  def stormy?
    rand(10) == 1
  end

end
