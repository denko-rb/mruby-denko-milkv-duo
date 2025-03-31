MAIN_LIB_PATH = "mrblib/denko/board"
BEHAVIORS_PATH = "mrblib/denko/behaviors"
require_relative "#{MAIN_LIB_PATH}/version"

MRuby::Gem::Specification.new('mruby-denko-board-milkv-duo') do |spec|
  spec.license = 'MIT'
  spec.authors = 'vickash'
  spec.version = Denko::Board::VERSION

  # Surely dependent on
  # spec.add_dependency('mruby-onig-regexp', github: 'mattn/mruby-onig-regexp')

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

  # Board files
  spec.rbfiles += Dir.glob("#{dir}/#{MAIN_LIB_PATH}/*")

  # Core IO classes
  spec.rbfiles << "#{dir}/mrblib/denko/digital_io/input.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/digital_io/output.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/pulse_io/pwm_output.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/analog_io/input_helper.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/analog_io/input.rb"

  # More Digital IO classes
  spec.rbfiles << "#{dir}/mrblib/denko/digital_io/button.rb"
  spec.rbfiles << "#{dir}/mrblib/denko/digital_io/relay.rb"

  # Motor classes
  spec.rbfiles << "#{dir}/mrblib/denko/motor/servo.rb"
end
