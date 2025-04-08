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
# SHT30/31/35 sensor over I2C, for temperature and humidity.
#
board  = Denko::Board.new
bus    = Denko::I2C::Bus.new(board: board, index: 0)
sensor = Denko::Sensor::SHT3X.new(bus: bus) # address: 0x44 default

# Heater control
sensor.heater_on
puts "Heater on: #{sensor.heater_on?}"
sensor.heater_off
puts "Heater off: #{sensor.heater_off?}"

# Reset (turns heater off)
sensor.reset
puts "Resetting..."
puts "Heater off: #{sensor.heater_off?}"
puts

# Set repeatability= :low, :medium or :high (default). See datasheet for details.
sensor.repeatability = :high

# Poll it and print readings.
sensor.on_data do |reading|
  print_tph_reading(reading)
end

loop do
  sensor.read
  sleep 5
end
