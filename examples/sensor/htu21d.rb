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
# HTU21D sensor over I2C, for temperature and humidity.
#
board  = Denko::Board.new
bus    = Denko::I2C::Bus.new(board: board, index: 0)
htu21d = Denko::Sensor::HTU21D.new(bus: bus) # address: 0x40 default

# Get and set heater state.
htu21d.heater_on
puts "Heater on: #{htu21d.heater_on?}"
htu21d.heater_off
puts "Heater off: #{htu21d.heater_off?}"
puts

# Back to default settings, except heater state.
htu21d.reset

# Only 4 resolution combinations are available, and need to be
# set by giving a bitmask from the datasheet:
#   0x00 = 14-bit temperature, 12-bit humidity
#   0x01 = 12-bit temperature,  8-bit humidity (default)
#   0x80 = 13-bit temperature, 10-bit humidity
#   0x81 = 11-bit temperature, 11-bit humidity
#
htu21d.resolution = 0x81
puts "Temperature resolution: #{htu21d.resolution[:temperature]} bits"
puts "Humidity resolution:    #{htu21d.resolution[:humidity]} bits"
puts

htu21d.read
puts "Temperature unit helpers: #{htu21d.temperature} \xC2\xB0C | #{htu21d.temperature_f} \xC2\xB0F | #{htu21d.temperature_k} K"
puts

# Poll it and print readings.
htu21d.on_data do |reading|
  print_tph_reading(reading)
end

loop do
  htu21d.read
  sleep 5
end
