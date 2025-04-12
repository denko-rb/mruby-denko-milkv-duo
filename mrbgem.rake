require_relative "mrblib/denko/version"

MRuby::Gem::Specification.new('mruby-denko-board-milkv-duo') do |spec|
  spec.license = 'MIT'
  spec.authors = 'vickash'
  spec.version = Denko::Board::VERSION

  main_lib_dir = "#{dir}/mrblib/denko"
  ext_lib_dir  = "#{dir}/ext/denko/lib/denko"
  behaviors_dir = "#{ext_lib_dir}/behaviors"

  # Essentials (specific to this mrbgem)
  spec.rbfiles = [
    "#{dir}/ext/ruby_bcd/lib/bcd.rb",
    "#{main_lib_dir}/version.rb",
    "#{main_lib_dir}/denko.rb",
    "#{ext_lib_dir}/mutex_stub.rb",
  ]

  # Behaviors (shared between main gem and this mrbgem)
  spec.rbfiles += [
    # Pin and component setup behaviors
    "#{behaviors_dir}/lifecycle.rb",
    "#{behaviors_dir}/state.rb",
    "#{behaviors_dir}/component.rb",
    "#{behaviors_dir}/single_pin.rb",
    "#{behaviors_dir}/input_pin.rb",
    "#{behaviors_dir}/output_pin.rb",
    "#{behaviors_dir}/multi_pin.rb",

    # Subcomponent behaviors
    "#{behaviors_dir}/subcomponents.rb",
    "#{behaviors_dir}/bus_controller.rb",
    "#{behaviors_dir}/bus_controller_addressed.rb",
    "#{behaviors_dir}/bus_peripheral.rb",
    "#{behaviors_dir}/bus_peripheral_addressed.rb",
    "#{behaviors_dir}/board_proxy.rb",

    # Input and callback behaviors
    "#{behaviors_dir}/callbacks.rb",
    "#{behaviors_dir}/reader.rb",
    "#{behaviors_dir}/threaded.rb",
    "#{behaviors_dir}/poller.rb",
    "#{behaviors_dir}/listener.rb",
  ]

  # Milk-V mruby specific board files
  spec.rbfiles += Dir.glob("#{main_lib_dir}/board/*")

  # Core IO classes
  spec.rbfiles << "#{ext_lib_dir}/digital_io/input.rb"
  spec.rbfiles << "#{ext_lib_dir}/digital_io/output.rb"
  spec.rbfiles << "#{ext_lib_dir}/digital_io/c_bit_bang.rb"
  spec.rbfiles << "#{ext_lib_dir}/pulse_io/pwm_output.rb"
  spec.rbfiles << "#{ext_lib_dir}/analog_io/input_helper.rb"
  spec.rbfiles << "#{ext_lib_dir}/analog_io/input.rb"

  # I2C Classes
  spec.rbfiles << "#{ext_lib_dir}/i2c/bus_common.rb"
  spec.rbfiles << "#{ext_lib_dir}/i2c/bus.rb"
  spec.rbfiles << "#{ext_lib_dir}/i2c/bit_bang.rb"
  spec.rbfiles << "#{ext_lib_dir}/i2c/peripheral.rb"

  # SPI Classes (stubs in main lib for now)
  spec.rbfiles << "#{main_lib_dir}/spi/bus.rb"
  spec.rbfiles << "#{main_lib_dir}/spi/bit_bang.rb"
  spec.rbfiles << "#{main_lib_dir}/spi/base_register.rb"

  # More Digital IO classes
  spec.rbfiles << "#{ext_lib_dir}/digital_io/button.rb"
  spec.rbfiles << "#{ext_lib_dir}/digital_io/relay.rb"
  spec.rbfiles << "#{ext_lib_dir}/digital_io/rotary_encoder.rb"

  # More Analog IO classes
  spec.rbfiles << "#{ext_lib_dir}/analog_io/potentiometer.rb"
  spec.rbfiles << "#{ext_lib_dir}/analog_io/joystick.rb"

  # More Pulse IO classes
  spec.rbfiles << "#{ext_lib_dir}/pulse_io/buzzer.rb"

  # LED Classes
  spec.rbfiles << "#{ext_lib_dir}/led/base.rb"
  spec.rbfiles << "#{ext_lib_dir}/led/rgb.rb"
  spec.rbfiles << "#{ext_lib_dir}/led/seven_segment.rb"

  # Motor classes
  spec.rbfiles << "#{ext_lib_dir}/motor/a3967.rb"
  spec.rbfiles << "#{ext_lib_dir}/motor/l298.rb"
  spec.rbfiles << "#{ext_lib_dir}/motor/servo.rb"

  # Display classes
  spec.rbfiles << "#{ext_lib_dir}/fonts.rb"
  spec.rbfiles << "#{ext_lib_dir}/display/canvas.rb"
  spec.rbfiles << "#{ext_lib_dir}/display/hd44780.rb"
  spec.rbfiles << "#{ext_lib_dir}/display/ssd1306.rb"
  spec.rbfiles << "#{ext_lib_dir}/display/sh1106.rb"

  # Sensors
  spec.rbfiles << "#{ext_lib_dir}/sensor/helper.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/generic_pir.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/aht.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/bme280.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/bmp180.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/htu21d.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/htu31d.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/qmp6988.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/sht3x.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/sht4x.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/vl53l0x.rb"

  # RTCS
  spec.rbfiles << "#{ext_lib_dir}/rtc/ds3231.rb"
end
