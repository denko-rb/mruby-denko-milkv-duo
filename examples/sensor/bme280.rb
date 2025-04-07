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
# BME280 sensor over I2C, for temperature, pressure and humidity.
#
board = Denko::Board.new
bus   = Denko::I2C::Bus.new(board: board, index: 0)

sensor = Denko::Sensor::BME280.new(bus: bus) # address: 0x76 default
# Use A BMP280 with no humidity instead.
# sensor = Denko::Sensor::BMP280.new(bus: bus) # address: 0x76 default

# Default reading mode is oneshot ("forced" in datasheet).
# sensor.oneshot_mode

# Enable oversampling independently on each sensor.
# sensor.temperature_samples = 8
# sensor.pressure_samples = 2
# sensor.humidity_samples = 4

# Enable continuous reading mode ("normal" in datasheet), with standby time and IIR filter.
# sensor.continuous_mode
# sensor.standby_time = 62.5
# sensor.iir_coefficient = 4

# Print raw config register bits.
# print sensor.config_register_bits

# Get the shared #print_tph_reading method to print readings neatly.

# Poll it and print readings.
sensor.on_data do |reading|
  print_tph_reading(reading)
end

loop do
  sensor.read
  sleep 5
end
