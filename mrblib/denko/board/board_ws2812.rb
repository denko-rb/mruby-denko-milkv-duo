module Denko
  class Board
    def show_ws2812(pin, pixel_buffer, spi_index:)
      spi_ws2812_write(spi_index, pixel_buffer)
    end
  end
end
