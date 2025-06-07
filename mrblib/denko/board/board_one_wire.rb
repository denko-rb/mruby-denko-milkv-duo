module Denko
  class Board
    def one_wire_reset(pin, read_presence=false)
      presence = _one_wire_reset(pin)
      self.update(pin, [presence]) if read_presence
    end

    def one_wire_search(pin, mask)
      bytes = []

      8.times do |i|
        addr = 0
        comp = 0
        8.times do |j|
          addr |= Duo.one_wire_bit_read(pin) << j
          comp |= Duo.one_wire_bit_read(pin) << j

          # A set (1) mask bit means we're searching a branch with that bit set.
          # Force it to be 1 on this pass. Write 1 to both the bus and address bit.
          #
          # Don't change the complement bit from 0, Even if the bus said 0/0,
          # send back 1/0, hiding known discrepancies, only sending new ones.
          #
          # Mask is a 64-bit number, not byte array.
          if ((mask >> (i*8 + j)) & 0b1) == 1
            Duo.one_wire_bit_write(pin, 1)
            addr |= 1 << j

          # Whether there was no "1-branch" marked for this bit, or there is no
          # discrepancy at all, just echo address bit to the bus. We will
          # compare addr/comp to find discrepancies for future passes.
          else
            Duo.one_wire_bit_write(pin, (addr >> j) & 0b1)
          end
        end
        bytes << addr
        bytes << comp
      end

      # 16 bytes, address and complement bytes interleaved LSByteFIRST.
      # DON'T CHANGE! #split_search_result deals with it.
      # MCUs send in this format to save RAM. Always match it.
      self.update(pin, bytes)
    end

    def one_wire_write(pin, parasite_power, bytes)
      bytes.each { |byte| one_wire_byte_write(pin, byte) }

      # Drive bus high to feed parasite capacitor if necessary.
      if parasite_power
        _set_pin_mode(pin, PINMODE_OUTPUT)
        digital_write(pin, HIGH)
      end
    end

    def one_wire_read(pin, num_bytes)
      bytes = []
      num_bytes.times { bytes << one_wire_byte_read(pin) }
      self.update(pin, bytes)
    end
  end
end
