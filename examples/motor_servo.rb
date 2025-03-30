board = Denko::Board.new
motor = Denko::Motor::Servo.new(board: board, pin: 4)

angles = (0..180).to_a + (1..179).to_a.reverse

angles.cycle do |angle|
  motor.angle = angle
  sleep 0.01
end
