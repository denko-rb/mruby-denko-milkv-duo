#
# VL53L0X sensor over I2C to measure distance.
#
board  = Denko::Board.new
bus    = Denko::I2C::Bus.new(board: board, index: 0)
sensor = Denko::Sensor::VL53L0X.new(bus: bus) # address: 0x29 default

# Correct for my sensor always being off by +52mm.
# Adjust this as needed to suit yours.
sensor.correction_offset = -52

sensor.on_data do |distance|
  puts "Distance: #{distance} mm"
end

loop do
  sensor.read
  sleep 0.5
end
