TRIGGER_PIN = 14
ECHO_PIN    = 15

board  = Denko::Board.new
hcsr04 = Denko::Sensor::HCSR04.new(board: board, pins: {trigger: TRIGGER_PIN, echo: ECHO_PIN})

loop do
  distance = hcsr04.read
  puts "Distance: #{distance.round} mm"
  sleep 1
end
