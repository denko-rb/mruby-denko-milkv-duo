module Denko
  class Board
    def spi_bb_transfer(select, clock: nil, input: -1, output: -1, write: [], read: 0, frequency: nil, mode: nil, bit_order: nil)
      input  = -1 unless input
      output = -1 unless output
      raise ArgumentError, "clock: pin must be given" unless clock
      raise ArgumentError, "input: or output: pin must be given" if (input == -1) && (output == -1)
      raise ArgumentError, "select: pin must be given when reading" if (read != 0) && (select == nil)
      raise ArgumentError, "no bytes given to read or write" if (read == 0) && (write.empty?)

      # Convert bit order symbol to an integer for C
      bit_order_int = (bit_order == :msbfirst) ? 1 : 0

      read_bytes = _spi_bb_transfer(clock, output, input, select, mode, bit_order_int, write, read)

      raise StandardError, "WiringX SPI error: #{read_bytes}" if read_bytes.class == Integer

      self.update(select, read_bytes) if (read > 0 && select)
    end

    def spi_bb_listen(*arg, **kwargs)
      raise NotImplementedError, "Board#spi_bb_listen not implemented on Milk-V Duo"
    end
  end
end
