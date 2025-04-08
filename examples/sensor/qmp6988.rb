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
# Example using QMP6988 sensor over I2C, for air temperature and pressure.
# Currently works only on bit-bang I2C buses.
#
I2C_BB_SCL = 16
I2C_BB_SDA = 17
board  = Denko::Board.new
bus = Denko::I2C::BitBang.new(board: board, pins: {scl: I2C_BB_SCL, sda: I2C_BB_SDA})
sensor = Denko::Sensor::QMP6988.new(bus: bus) # address: 0x70 default

# Verify chip_id.
print "I2C device has chip ID: 0x#{sensor.chip_id.to_s(16).upcase}. "
if sensor.chip_id == 0x5C
  puts "This matches the QMP6988."
else
  puts "This does not match the QMP6988."
  return
end
puts

#
# Change measurement settings:
#   temperature_samples can be 1,2,4,8,16,32 or 64 (default: 1)
#   pressure_samples    can be 1,2,4,8,16,32 or 64 (default: 1)
#   iir_coefficient     can be 0,2,4,8,16 or 32    (default: 0)
#
# High accuracy settings from datasheet, with IIR of 2.
sensor.temperature_samples = 2
sensor.pressure_samples    = 16
sensor.iir_coefficient     = 2

#
# Change mode (default: forced_mode)
#
# Buggy on ESP32S3 in forced mode. Data registers return zeroes on all but first read.
# Can't recreate on ESP32 V1, AVR or SAMD21. Put it in contiuous mode just in case.
sensor.continuous_mode
# sensor.forced_mode

#
# Set standby time (between measurements) for continuous mode only:
#   standby_time (given in ms) can be 1,5,20,250,500,1000,2000 or 4000 (default: 1)
#
# sensor.standby_time = 500

# Poll it and print readings.
sensor.on_data do |reading|
  print_tph_reading(reading)
end

loop do
  sensor.read
  sleep 5
end
