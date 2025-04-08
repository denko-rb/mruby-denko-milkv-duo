module Denko
  class Board
    # i2c_bb_setup defined in C

    def i2c_bb_search(scl,sda)
      found = _i2c_bb_search(scl,sda)
      # Prepend 0 (invalid address) to avoid bus treating this as peripheral data.
      found ? found.unshift(0) : found = []
      update(sda, found)
    end

    # i2c_bb_search defined in C

    def i2c_bb_write(scl, sda, address, bytes, repeated_start=false)
      bytes = [bytes] unless bytes.class == Array
      _i2c_bb_write(scl, sda, address, bytes)
    end

    def i2c_bb_read(scl, sda, address, register, read_length, repeated_start=false)
      if register
        register = [register] unless register.class == Array
        _i2c_bb_write(scl, sda, address, register)
      end

      bytes = _i2c_bb_read(scl, sda, address, read_length)

      # Prepend the address (0th element) to the data, and update the bus.
      bytes.unshift(address) if bytes
      update(sda, bytes)
    end
  end
end
