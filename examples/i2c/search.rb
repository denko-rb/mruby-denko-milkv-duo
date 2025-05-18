I2C_DEV = 0
board = Denko::Board.new
bus = Denko::I2C::Bus.new(board: board, index: I2C_DEV)
# bus = Denko::I2C::BitBang.new(board: board, pins: {scl: 16, sda: 17})
bus.search

puts "I2C addresses on the bus:"
bus.found_devices.each do |device|
  puts "0x#{device.to_s(16).upcase}"
end
