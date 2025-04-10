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
# SHT40 sensor over I2C, for temperature and humidity.
#
I2C_BB_SCL = 16
I2C_BB_SDA = 17
board  = Denko::Board.new
bus = Denko::I2C::BitBang.new(board: board, pins: {scl: I2C_BB_SCL, sda: I2C_BB_SDA})
sensor = Denko::Sensor::SHT4X.new(bus: bus) # address: 0x44 default

# Read and print the unique serial number
puts "Serial Number: Ox#{sensor.serial.to_s(16).upcase}" if sensor.serial
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
