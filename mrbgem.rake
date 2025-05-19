require_relative "mrblib/denko/version"

MRuby::Gem::Specification.new('mruby-denko-milkv-duo') do |spec|
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
    "#{ext_lib_dir}/helpers/engine_check.rb",
    "#{ext_lib_dir}/helpers/mutex_stub.rb",
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

  # AnalogIO
  spec.rbfiles << "#{ext_lib_dir}/analog_io/input_helper.rb"
  spec.rbfiles << "#{ext_lib_dir}/analog_io/input.rb"
  spec.rbfiles << "#{ext_lib_dir}/analog_io/potentiometer.rb"
  spec.rbfiles << "#{ext_lib_dir}/analog_io/joystick.rb"

  # DigitalIO
  spec.rbfiles << "#{ext_lib_dir}/digital_io/input.rb"
  spec.rbfiles << "#{ext_lib_dir}/digital_io/output.rb"
  spec.rbfiles << "#{ext_lib_dir}/digital_io/button.rb"
  spec.rbfiles << "#{ext_lib_dir}/digital_io/relay.rb"
  spec.rbfiles << "#{ext_lib_dir}/digital_io/rotary_encoder.rb"
  spec.rbfiles << "#{ext_lib_dir}/digital_io/c_bit_bang.rb"

  # PulseIO
  spec.rbfiles << "#{ext_lib_dir}/pulse_io/pwm_output.rb"
  spec.rbfiles << "#{ext_lib_dir}/pulse_io/buzzer.rb"

  # I2C
  spec.rbfiles << "#{ext_lib_dir}/i2c/bus_common.rb"
  spec.rbfiles << "#{ext_lib_dir}/i2c/bus.rb"
  spec.rbfiles << "#{ext_lib_dir}/i2c/bit_bang.rb"
  spec.rbfiles << "#{ext_lib_dir}/i2c/peripheral.rb"

  # SPI Classes
  spec.rbfiles << "#{ext_lib_dir}/spi/bus_common.rb"
  spec.rbfiles << "#{ext_lib_dir}/spi/bus.rb"
  spec.rbfiles << "#{ext_lib_dir}/spi/bit_bang.rb"
  spec.rbfiles << "#{ext_lib_dir}/spi/peripheral.rb"
  spec.rbfiles << "#{ext_lib_dir}/spi/base_register.rb"
  spec.rbfiles << "#{ext_lib_dir}/spi/input_register.rb"
  spec.rbfiles << "#{ext_lib_dir}/spi/output_register.rb"

  # Digital IO (over I2C)
  spec.rbfiles << "#{ext_lib_dir}/digital_io/pcf8574.rb"

  # Display
  spec.rbfiles << "#{ext_lib_dir}/display/hd44780.rb"
  # Pixel display mixins and helperss
  spec.rbfiles << "#{ext_lib_dir}/display/pixel_common.rb"
  spec.rbfiles << "#{ext_lib_dir}/display/spi_common.rb"
  spec.rbfiles << "#{ext_lib_dir}/display/spi_epaper_common.rb"
  # Fonts and Canvas
  spec.rbfiles << "#{ext_lib_dir}/display/font/bmp_5x7.rb"
  spec.rbfiles << "#{ext_lib_dir}/display/font/bmp_6x8.rb"
  spec.rbfiles << "#{ext_lib_dir}/display/font/bmp_8x16.rb"
  spec.rbfiles << "#{ext_lib_dir}/display/canvas.rb"
  # OLEDs
  spec.rbfiles << "#{ext_lib_dir}/display/mono_oled.rb"
  spec.rbfiles << "#{ext_lib_dir}/display/ssd1306.rb"
  spec.rbfiles << "#{ext_lib_dir}/display/sh1106.rb"
  spec.rbfiles << "#{ext_lib_dir}/display/sh1107.rb"
  # LCDs
  spec.rbfiles << "#{ext_lib_dir}/display/pcd8544.rb"
  spec.rbfiles << "#{ext_lib_dir}/display/st7302.rb"
  spec.rbfiles << "#{ext_lib_dir}/display/st7565.rb"
  # E-paper
  spec.rbfiles << "#{ext_lib_dir}/display/il0373.rb"
  spec.rbfiles << "#{ext_lib_dir}/display/ssd168x.rb"
  spec.rbfiles << "#{ext_lib_dir}/display/ssd1680.rb"
  spec.rbfiles << "#{ext_lib_dir}/display/ssd1681.rb"

  # EEPROM
  spec.rbfiles << "#{ext_lib_dir}/eeprom/at24c.rb"

  # LED
  spec.rbfiles << "#{ext_lib_dir}/led/base.rb"
  spec.rbfiles << "#{ext_lib_dir}/led/rgb.rb"
  spec.rbfiles << "#{ext_lib_dir}/led/seven_segment.rb"
  spec.rbfiles << "#{ext_lib_dir}/led/apa102.rb"

  # Motors
  spec.rbfiles << "#{ext_lib_dir}/motor/servo.rb"
  spec.rbfiles << "#{ext_lib_dir}/motor/a3967.rb"
  spec.rbfiles << "#{ext_lib_dir}/motor/l298.rb"

  # RTC
  spec.rbfiles << "#{ext_lib_dir}/rtc/ds3231.rb"

  # Sensor
  spec.rbfiles << "#{ext_lib_dir}/sensor/helper.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/generic_pir.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/aht.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/bme280.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/bmp180.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/hdc1080.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/htu21d.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/htu31d.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/qmp6988.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/sht3x.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/sht4x.rb"
  spec.rbfiles << "#{ext_lib_dir}/sensor/vl53l0x.rb"
end
