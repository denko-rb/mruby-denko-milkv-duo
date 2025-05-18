# This helper method can be used in temp/pressure/humidity sensor examples.
# Give a hash with readings as float values and it prints them neatly.
#
def print_tph_reading(reading)
  elements = []

  # Temperature
  if reading[:temperature]
    formatted_temp = reading[:temperature].to_f.round(2).to_s.ljust(5, '0')
    elements << "Temperature: #{formatted_temp} \xC2\xB0C"
  end

  # Pressure
  if reading[:pressure]
    formatted_pressure = reading[:pressure].round(2).to_s.ljust(7, '0')
    elements << "Pressure: #{formatted_pressure} Pa"
  end

  # Humidity
  if reading[:humidity]
    formatted_humidity = reading[:humidity].round(2).to_s.ljust(5, '0')
    elements << "Humidity: #{formatted_humidity} %"
  end

  return if elements.empty?

  # Time
  print "#{Time.now} - "

  puts elements.join(" | ")
end

#
# Most enviro sensors over I2C have the same interface.
#
board  = Denko::Board.new
bus    = Denko::I2C::Bus.new(board: board, index: 0)

sensor = Denko::Sensor::AHT1X.new(bus: bus) # address: 0x38 default
# sensor = Denko::Sensor::AHT2X.new(bus: bus) # address: 0x38 default
# sensor = Denko::Sensor::AHT3X.new(bus: bus) # address: 0x38 default
# sensor = Denko::Sensor::BME280.new(bus: bus) # address: 0x76 default
# sensor = Denko::Sensor::BMP180.new(bus: bus) # address: 0x77 default
# sensor = Denko::Sensor::HDC1080.new(bus: bus) # address: 0x40 default
# sensor = Denko::Sensor::HTU21D.new(bus: bus) # address: 0x40 default
# sensor = Denko::Sensor::HTU31D.new(bus: bus) # address: 0x40 default
# sensor = Denko::Sensor::QMP6988.new(bus: bus) # address: 0x70 default
# sensor = Denko::Sensor::SHT3X.new(bus: bus) # address: 0x44 default
# sensor = Denko::Sensor::SHT4X.new(bus: bus) # address: 0x44 default

sensor.on_data do |reading|
  print_tph_reading(reading)
end

loop do
  sensor.read
  sleep 5
end
