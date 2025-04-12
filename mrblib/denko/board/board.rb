module Denko
  class Board
    include Behaviors::Subcomponents

    def platform
      :linux_milkv_duo
    end

    def initialize
       @adc_initialized = Duo.saradc_initialize
    end

    def convert_pin(pin)
      pin.to_i
    end

    def low
      0
    end

    def high
      1
    end

    # Milk-V Duo analog input is always 12-bit.
    def analog_read_resolution
      12
    end

    def analog_read_high
      4095
    end
    alias :adc_high :analog_read_high

    # Milk-V Duo PWM write is in nanoseconds, so no PWM resolution needed.
    def analog_write_resolution
      nil
    end

    def map
      @map ||= generate_board_map
    end

    # Applies to Duo and Duo256, but NOT DuoS.
    GPIO_LIST = (0..22).to_a + [25,26,27]

    # Use the included duo-pinmux program to map out which pins are muxed to what.
    def generate_board_map
      map = []
      GPIO_LIST.each do |num|
        lines = `duo-pinmux -r GP#{num}`.split("\n")
        lines.each do |line|
          if line[0..2] == "[v]"
            map[num] = line[4..-1].downcase.gsub("iic", "i2c").to_sym
          end
        end
      end
      map
    end

    def pin_is_pwm?(pin)
      map[convert_pin(pin)].to_s[0..2].downcase == "pwm"
    end

    def update(pin, message)
      if single_pin_components[pin]
        single_pin_components[pin].update(message)
      end
    end

    # Get GPIO alerts from queue and run callbacks for single pin components.
    # Must be called periodically in the user script.
    def handle_listeners
      loop do
        alert = get_alert
        break unless alert
        update(alert[:pin], alert[:level])
      end
    end
  end
end
