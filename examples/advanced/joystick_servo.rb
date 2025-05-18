X_PIN = 26
Y_PIN = 27
SERVO_PIN = 4

board = Denko::Board.new
servo = Denko::Motor::Servo.new(board: board, pin: SERVO_PIN)
joystick = Denko::AnalogIO::Joystick.new  board: board,
                                          pins: {x: X_PIN, y: Y_PIN},
                                          invert_x: true,
                                          invert_y: true,
                                          # swap_axes: true,
                                          maxzone: 96,  # as percentage
                                          deadzone: 20  # as percentage

joystick.x.smoothing = true
joystick.y.smoothing = true

# Simple ~50Hz loop.
loop do
  last_tick = Time.now

  reading = joystick.read
  angle = 90 + ((reading[:y] / 100.0) * 90).round
  unless servo.angle == angle
    servo.angle = angle
    puts "Servo angle: #{angle}"
  end

  sleep 0.02
end
