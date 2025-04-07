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
# BMP180 sensor over I2C, for temperature and pressure.
#
board  = Denko::Board.new
bus    = Denko::I2C::Bus.new(board: board, index: 0)
sensor = Denko::Sensor::BMP180.new(bus: bus) # address: 0x77 default

# Enable oversampling for the pressure sensor only (1,2,4, 8).
# sensor.pressure_samples = 8

# Demonstrate helper methods
result = sensor.read
puts "Temperature unit helpers: #{sensor.temperature} \xC2\xB0C | #{sensor.temperature_f} \xC2\xB0F | #{sensor.temperature_k} K"
puts "Pressure unit helpers: #{sensor.pressure} Pa | #{sensor.pressure_atm.round(6)} atm | #{sensor.pressure_bar.round(6)} bar"
puts

loop do
  print_tph_reading(sensor.read)
  sleep 5
end
