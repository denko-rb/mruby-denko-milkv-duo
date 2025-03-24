PIN = 26
board = Denko::Board.new
input = Denko::AnalogIO::Input.new(board: board, pin: PIN)

input.on_data do |level|
  puts "GP26 Analog Level: #{level}"
end

loop do
  input.read
  sleep 0.5
end
