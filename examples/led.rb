# Blink the built-in LED.
PIN = 25

board = Denko::Board.new
led = Denko::LED.new(board: board, pin: PIN)

loop do
  led.toggle
  sleep 0.5
end
