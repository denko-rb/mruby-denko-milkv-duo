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

    # Use the included duo-pinmux program to map out which pins are muxed to what.
    # Available pins for WiringX from: https://milkv.io/docs/duo/application-development/wiringx
    def generate_board_map
      gpio_list = []
      if ["milkv_duo", "milkv_duo256m"].include? variant
        # Duo and Duo 256M
        gpio_list += (0..22).to_a
        gpio_list += [25,26,27]
      else
        # Duo S J3 Header
        gpio_list += [3,5,7,8,10,11,12,13,15,16,18,19,21,22,23,24,26]
        # Duo S J4 Header
        gpio_list += (27..30).to_a
        gpio_list += (33..36).to_a
        gpio_list += (39..42).to_a
        gpio_list += [44,46,48,50]
      end

      map = {}
      gpio_list.each do |num|
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
      map[convert_pin(pin)].to_s.downcase.start_with? "pwm"
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
