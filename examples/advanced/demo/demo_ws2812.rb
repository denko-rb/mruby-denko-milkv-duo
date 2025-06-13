# CPU usage montior on an 8 pixel WS2812 strip.
SPI_MOSI = 7
PIXELS   = 8
COLOR    = [0, 0, 32]

positions = (0..PIXELS-1).to_a + (1..PIXELS-2).to_a.reverse

board = Denko::Board.new
bus   = Denko::SPI::Bus.new(board: board)
strip = Denko::LED::WS2812.new(board: bus, pin: SPI_MOSI, length: PIXELS)

loop do
  # Taken from: https://askubuntu.com/questions/274349/getting-cpu-usage-realtime
  cpu_usage = `cat <(grep 'cpu ' /proc/stat) <(sleep 1 && grep 'cpu ' /proc/stat) | awk -v RS="" '{print ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)}'`
  cpu_usage = cpu_usage.strip.to_f
  pixel_count = (cpu_usage / 100.0 * 8).round
  strip.clear
  # WS2812 strip is upside down.
  pixel_count.times do |index|
    strip[PIXELS - (index+1)] = COLOR
  end
  strip.show
end
