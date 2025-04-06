module Denko
  class Board
    # Address ranges 0..7 and 120..127 are reserved.
    # Allow search in in 8..119 (0x08 to 0x77).
    I2C_ADDRESS_RANGE = (0x08..0x77).to_a

    # Arbitrary 256kB limit for now
    def i2c_limit
      262144
    end

    def i2c_handle(index, address)
      @i2c_handles ||= []
      @i2c_handles[index] ||= []
      @i2c_handles[index][address] ||= i2c_setup(index, address)
    end

    def i2c_search(index)
      # Prepend 0 (invalid address) so
      found = [0]
      I2C_ADDRESS_RANGE.each do |address|
        handle = i2c_handle(index, address)
        bytes = _i2c_read(handle, 1)
        if (bytes.class == Array) && (bytes[0]) > 0
          found << address
        end
      end
      return found
    end

    # Frequency ignored, locked at 400kHz. Repeated start unavailable
    def i2c_write(index, address, bytes, frequency=100000, repeated_start=false)
      raise ArgumentError, "exceeded #{i2c_limit} bytes for #i2c_write" if bytes.length > i2c_limit
      result = _i2c_write(i2c_handle(index, address), bytes)
      i2c_c_error("write", result, index, address) if result < 0
      result
    end

    # Frequency ignored, locked at 400kHz. Repeated start unavailable
    def i2c_read(index, address, register, read_length, frequency=100000, repeated_start=false)
      handle = i2c_handle(index, address)

      if register
        register = [register].flatten
        result = _i2c_write(handle, register)
        i2c_c_error("read (register write)", result, index, address) if result < 0
      end

      bytes = _i2c_read(handle, read_length)
      i2c_c_error("read", bytes, index, address) if bytes.class == Integer

      # Prepend the address (0th element) to the data, and update the bus.
      bytes.unshift(address)
      update_i2c(index, bytes)
    end

    def update_i2c(index, data)
      dev = hw_i2c_comps[index]
      dev.update(data) if dev
    end

    def i2c_c_error(name, error, index, address)
      raise StandardError, "WiringX I2C #{name} error: #{error} for /dev/i2c-#{index} with address 0x#{address.to_s(16).upcase}"
    end
  end
end
