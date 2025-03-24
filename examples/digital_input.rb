PIN = 14
board = Denko::Board.new
input = Denko::DigitalIO::Input.new(board: board, pin: PIN)

input.listen do |level|
  puts "Pin 14 level: #{level}"
end

loop do
  board.update
  sleep 0.010
end
