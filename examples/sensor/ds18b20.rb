PIN   = 16
board = Denko::Board.new
bus   = Denko::OneWire::Bus.new(board: board, pin: PIN)

unless bus.device_present?
  puts "No devices present on bus... Quitting..."
  return
end

if bus.parasite_power
  puts "Parasite power detected..."; puts
end

# Search the bus and use results to set up DS18B20 instances.
bus.search
ds18b20s = []
bus.found_devices.each do |d|
  if d[:class] == Denko::Sensor::DS18B20
    ds18b20s << d[:class].new(bus: bus, address: d[:address])
  end
end

# Format a reading for printing on a line.
def print_reading(reading, sensor)
  print "#{Time.now} - "
  print "Serial(HEX): #{sensor.serial_number} | Res: #{sensor.resolution} bits | "

  if reading[:crc_error]
    puts "CRC check failed for this reading!"
  else
    fahrenheit = (reading[:temperature] * 1.8 + 32).round(1)
    puts "#{reading[:temperature]} \xC2\xB0C | #{fahrenheit} \xC2\xB0F"
  end
end

if ds18b20s.empty?
  puts "No DS18B20 sensors found on the bus... Quitting...";
else
  puts "Found DS18B20 sensors with these serials:"
  puts ds18b20s.map { |d| d.serial_number }
  puts

  loop do
    ds18b20s.each do |sensor|
      sensor.read do |reading|
        print_reading(reading, sensor)
      end
    end

    sleep 5
  end
end
