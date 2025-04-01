#
# KY-040 (30 detent) rotary encoder, polled at 0.1ms.
#
# WARNING: This method is not precise and may miss steps. Don't use for anything
# that requires all steps to be read for exact positioning or high speed.
#
PIN_A = 16
PIN_B = 17

board = Denko::Board.new

# Other options and their default values:
#
# counts_per_revolution: 60  # for generic 30 detent rotary encoders
#
encoder = Denko::DigitalIO::RotaryEncoder.new board: board,
                                              pins:  { a: PIN_A, b: PIN_B }

# Reverse direction.
encoder.reverse

# Reset count and angle to 0.
# encoder.reset

encoder.add_callback do |state|
  change_printable = state[:change].to_s
  change_printable = "+#{change_printable}" if state[:change] > 0
  puts "Encoder Change: #{change_printable} | Count: #{state[:count]} | Angle: #{state[:angle]}\xC2\xB0"
end

# Keep getting events from the listen queue, so the encoder state updates.
loop do
  board.update
  sleep 0.010
end
