PIN = 6

board = Denko::Board.new
led = Denko::LED.new(board: board, pin: PIN)

min = 0
max = 100
values = (min..max).to_a + (min..max-1).to_a.reverse

values.cycle do |value|
  led.duty = value
  sleep 0.005
end
