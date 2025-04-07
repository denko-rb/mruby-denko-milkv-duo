MAIN_LIB_PATH = "mrblib/denko/board"
BEHAVIORS_PATH = "mrblib/denko/behaviors"
require_relative "#{MAIN_LIB_PATH}/version"

MRuby::Gem::Specification.new('mruby-denko-board-milkv-duo') do |spec|
  spec.license = 'MIT'
  spec.authors = 'vickash'
  spec.version = Denko::Board::VERSION

  spec.rbfiles = [
    # Pin and component setup behaviors
    "#{dir}/#{BEHAVIORS_PATH}/lifecycle.rb",
    "#{dir}/#{BEHAVIORS_PATH}/state.rb",
    "#{dir}/#{BEHAVIORS_PATH}/component.rb",
    "#{dir}/#{BEHAVIORS_PATH}/single_pin.rb",
    "#{dir}/#{BEHAVIORS_PATH}/input_pin.rb",
    "#{dir}/#{BEHAVIORS_PATH}/output_pin.rb",
    "#{dir}/#{BEHAVIORS_PATH}/multi_pin.rb",

    # Subcomponent behaviors
    "#{dir}/#{BEHAVIORS_PATH}/subcomponents.rb",
    "#{dir}/#{BEHAVIORS_PATH}/bus_controller.rb",
    "#{dir}/#{BEHAVIORS_PATH}/bus_controller_addressed.rb",
    "#{dir}/#{BEHAVIORS_PATH}/bus_peripheral.rb",
    "#{dir}/#{BEHAVIORS_PATH}/bus_peripheral_addressed.rb",
    "#{dir}/#{BEHAVIORS_PATH}/board_proxy.rb",

    # Input and callback behaviors
    "#{dir}/#{BEHAVIORS_PATH}/callbacks.rb",
    "#{dir}/#{BEHAVIORS_PATH}/reader.rb",
    "#{dir}/#{BEHAVIORS_PATH}/poller.rb",
    "#{dir}/#{BEHAVIORS_PATH}/listener.rb",
  ]

  # BCD from the CRuby gem
  spec.rbfiles << "#{dir}/ext/ruby_bcd/lib/bcd.rb"

  # Board files
  spec.rbfiles += Dir.glob("#{dir}/#{MAIN_LIB_PATH}/*")

  # Core IO classes
  spec.rbfiles << "#{dir}/mrblib/denko/digital_io/input.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/digital_io/output.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/pulse_io/pwm_output.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/analog_io/input_helper.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/analog_io/input.rb"

  # I2C Classes
  spec.rbfiles << "#{dir}/mrblib/denko/i2c/bus_common.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/i2c/bus.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/i2c/bit_bang.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/i2c/peripheral.rb"

  # SPI Classes
  spec.rbfiles << "#{dir}/mrblib/denko/spi/bus.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/spi/bit_bang.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/spi/base_register.rb"

  # More Digital IO classes
  spec.rbfiles << "#{dir}/mrblib/denko/digital_io/button.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/digital_io/relay.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/digital_io/rotary_encoder.rb"

  # More Analog IO classes
  spec.rbfiles << "#{dir}/mrblib/denko/analog_io/potentiometer.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/analog_io/joystick.rb"

  # More Pulse IO classes
  spec.rbfiles << "#{dir}/mrblib/denko/pulse_io/buzzer.rb"

  # LED Classes
  spec.rbfiles << "#{dir}/mrblib/denko/led/base.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/led/rgb.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/led/seven_segment.rb"

  # Motor classes
  spec.rbfiles << "#{dir}/mrblib/denko/motor/a3967.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/motor/l298.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/motor/servo.rb"

  # Display classes
  spec.rbfiles << "#{dir}/mrblib/denko/fonts.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/display/canvas.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/display/hd44780.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/display/ssd1306.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/display/sh1106.rb"

  # Sensors
  spec.rbfiles << "#{dir}/mrblib/denko/sensor/generic_pir.rb"

  # RTCS
  spec.rbfiles << "#{dir}/mrblib/denko/rtc/ds3231.rb"
end
