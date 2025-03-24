# Connect an LED to GPIO4
PIN = 4

board = Denko::Board.new
pwm = Denko::PulseIO::PWMOutput.new(board: board, pin: PIN)

steps = (0..100).to_a + (1..99).to_a.reverse

# Fade the LED up and down.
steps.cycle do |value|
  pwm.duty = value
  sleep 0.02
end
