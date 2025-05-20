module Denko
  class Board
    LSBFIRST_LUT = Array.new(256) do |byte|
      byte.to_s(2).rjust(8, '0').reverse.to_i(2)
    end

    def spi_transfer(spi_index, select, write: [], read: 0, frequency: 1_000_000, mode: 0, bit_order: :msbfirst)
      raise ArgumentError, "no bytes to read or write" if (read == 0) && (write.empty?)
      raise ArgumentError, "select pin cannot be nil when reading" if (read != 0) && (select == nil)
      raise ArgumentError, "hardware SPI only supports mode 0 on Milk-V Duo" unless (mode == 0)

      # Reverse bit order of write bytes if LSBFIRST.
      if bit_order == :msbfirst
        write_bytes = write
      else
        write_bytes = write.map { |byte| LSBFIRST_LUT[byte] }
      end

      digital_write(select, 0) if select
      read_bytes = _spi_transfer(spi_index, frequency, write_bytes, read)
      digital_write(select, 1) if select

      raise StandardError, "WiringX SPI error: #{read_bytes}" if read_bytes.class == Integer

      # Reverse bit order of read bytes if LSBFIRST.
      if bit_order != :msbfirst
        read_bytes = read_bytes.map { |byte| LSBFIRST_LUT[byte] }
      end

      self.update(select, read_bytes) if (read > 0 && select)
    end

    def spi_listen(spi_index, select, read: 0, frequency: nil, mode: nil, bit_order: nil)
      raise NotImplementedError, "Board#spi_listen not implemented on Milk-V Duo"
    end

    def spi_listeners
      @spi_listeners ||= Array.new
    end
  end
end
