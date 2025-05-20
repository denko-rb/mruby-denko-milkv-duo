SPI_MOSI = 7
PIXELS   = 8

RED    = [255, 0, 0]
GREEN  = [0, 255, 0]
BLUE   = [0, 0, 255]
WHITE  = [255, 255, 255]
COLORS = [RED, GREEN, BLUE, WHITE]

positions = (0..PIXELS-1).to_a + (1..PIXELS-2).to_a.reverse

board = Denko::Board.new
bus   = Denko::SPI::Bus.new(board: board, index: 2)
strip = Denko::LED::WS2812.new(board: bus, pin: SPI_MOSI, length: PIXELS)

loop do
  COLORS.each do |color|
    positions.each do |index|
      strip.clear
      strip[index] = color
      strip.show
      sleep 0.05
    end
  end
end
