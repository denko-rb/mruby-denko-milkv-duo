I2C_DEV = 0
board = Denko::Board.new
bus = Denko::I2C::Bus.new(board: board, index: I2C_DEV)
bus.search
puts bus.found_devices.inspect
