X_PIN = 26
Y_PIN = 27

board = Denko::Board.new
joystick = Denko::AnalogIO::Joystick.new  board: board,
                                          pins: {x: X_PIN, y: Y_PIN},
                                          invert_x: true,
                                          invert_y: true,
                                          # swap_axes: true,
                                          maxzone: 96,  # as percentage
                                          deadzone: 20  # as percentage

# Simple ~50Hz loop.
loop do
  last_tick = Time.now

  joystick.read
  puts joystick.state.inspect

  sleep 0.02
end
