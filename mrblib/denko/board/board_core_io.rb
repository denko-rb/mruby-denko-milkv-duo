module Denko
  class Board
    INPUT_MODES  = [:input, :input_pullup, :input_pulldown]
    OUTPUT_MODES = [:output, :output_pwm, :output_open_drain, :output_open_source]
    PIN_MODES = INPUT_MODES + OUTPUT_MODES
    COMPATIBLE_MODES = [:input, :output, :output_pwm]

    def set_pin_mode(pin, mode=:input, options={})
      # Is the pin valid?
      raise ArgumentError, "pin: #{pin} is not a valid GPIO" unless valid_gpio(pin)

      # Is the mode valid?
      unless PIN_MODES.include?(mode)
        raise ArgumentError, "cannot set mode: #{mode}. Should be one of: #{COMPATIBLE_MODES.inspect}"
      end

      if mode == :output_pwm
        unless (map[pin] && map[pin].to_s[0..2] == "pwm")
          raise ArgumentError, "pin: #{pin} is not muxed to a PWM channel"
        end

        # Frequency as given, or default to 1kHz.
        period = 1_000_000
        if options[:frequency]
          period = (1_000_000_000 / options[:frequency].to_f).round
        end
        pwm_set_period(pin, period)

        # Only normal polarity for now.
        pwm_set_polarity(pin, 0)
        pwm_enable(pin, 1)
      else
        # Duo only has :input and :output modes.
        # Warn for lack of pull up, pull down, open drain, open source, then fall back.
        if mode.to_s[0..4] == "input" && mode != :input
          puts "WARNING: pin mode #{mode} not available on Milk-V Duo. Falling back to :input"
        end

        if mode.to_s[0..5] == "output" && mode != :output
          puts "WARNING: pin mode #{mode} not available on Milk-V Duo. Falling back to :output"
        end

        OUTPUT_MODES.include?(mode) ? _set_pin_mode(pin, PINMODE_OUTPUT) : _set_pin_mode(pin, PINMODE_INPUT)
      end
    end

    def set_pin_debounce(pin, debounce_time)
      puts "WARNING: Board#set_pin_debounce not available on Milk-V Duo. Ignoring..."
    end

    # digital_write implemented in C
    # digital_read implemented in C
    # pwm_write implemented in C

    def dac_write(pin, value)
      raise NotImplementedError, "Board#dac_write not available on Milk-V Duo"
    end

    def analog_read(pin, negative_pin=nil, gain=nil, sample_rate=nil)
      _analog_read(pin)
    end

    def set_listener(pin, state=:off, options={})
      raise NotImplementedError, "analog listeners not available on Milk-V" if (options[:mode] == :analog)

      if state == :on
        _set_pin_mode(pin, PINMODE_INPUT)
        claim_alert(pin)
      else
        # Unset pin mode?
        stop_alert(pin)
      end
    end

    def digital_listen(pin, divider=nil)
      # Divider is ignored
      set_listener(pin, :on)
    end

    def analog_listen(pin, divider=nil)
      raise NotImplementedError, "Board#analog_listen not available on Milk-V Duo"
    end

    def stop_listener(pin)
      set_listener(pin, :off)
    end

    def set_register_divider(value)
      raise NotImplementedError, "Board#set_register_divider not available on Milk-V Duo"
    end

    def set_analog_write_resolution(value)
      raise NotImplementedError, "Board#set_analog_write_resolution not available on Milk-V Duo"
    end

    def set_analog_read_resolution(value)
      raise NotImplementedError, "Board#set_analog_read_resolution not available on Milk-V Duo"
    end

    # micro_delay implemented in C
  end
end
