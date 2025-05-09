#
# A standard 3 pin RGB LED (not single pin addressable), on 3 PWM pins.
#
RED_PIN   = 6
GREEN_PIN = 7
BLUE_PIN  = 8

board   = Denko::Board.new
rgb_led = Denko::LED::RGB.new board: board,
                              pins: {red: RED_PIN, green: GREEN_PIN, blue: BLUE_PIN}

# Set these predefined colors with symbols.
[:red, :green, :blue, :cyan, :yellow, :magenta, :white, :off].each do |color|
  rgb_led.color = color
  sleep 0.5
end

# Set duty cycle for each "sub LED".
loop do
  rgb_led.red.duty   = 100
  rgb_led.green.duty = 50
  rgb_led.blue.duty  = 0
  sleep 0.5
  rgb_led.red.duty   = 100
  rgb_led.green.duty = 0
  rgb_led.blue.duty  = 50
  sleep 0.5
end
