module Denko
  class Board
    INPUT_MODES  = [:input, :input_pullup, :input_pulldown]
    OUTPUT_MODES = [:output, :output_pwm, :output_open_drain, :output_open_source]
    PIN_MODES = INPUT_MODES + OUTPUT_MODES
    COMPATIBLE_MODES = [:input, :output, :output_pwm]

    def enabled_pwms
      @enabled_pwms ||= []
    end

    def set_pin_mode(pin, mode=:input, options={})
      # Is the pin valid?
      raise ArgumentError, "pin: #{pin} is not a valid GPIO" unless valid_gpio(pin)

      # Is the mode valid?
      unless PIN_MODES.include?(mode)
        raise ArgumentError, "cannot set mode: #{mode}. Should be one of: #{COMPATIBLE_MODES.inspect}"
      end

      if mode == :output_pwm
        unless pin_is_pwm?(pin)
          raise ArgumentError, "pin: #{pin} is not muxed to a PWM channel"
        end

        # Look for given period or frequency.
        period = nil
        if options[:period]
          period = options[:period]
        elsif options[:frequency]
          period = (1_000_000_000.0 / options[:frequency]).round
        end

        # If PWM was already enabled, only change period, and only if given.
        if enabled_pwms[pin]
          pwm_set_period(pin, period) if period
        else
          # Default period to 1 million ns (1kHz frequency).
          period ||= 1_000_000
          pwm_set_period(pin, period)

          pwm_set_polarity(pin, 0) # Normal polarity
          pwm_enable(pin, 1)
          pwm_write(pin, 0)

          enabled_pwms[pin] = true
        end
      else
        # Duo only has :input and :output modes.
        # Warn for lack of pull up, pull down, open drain, open source, then fall back.
        if mode.to_s.start_with?("input") && mode != :input
          puts "WARNING: pin mode #{mode} not available on Milk-V Duo. Falling back to :input"
        end

        if mode.to_s.start_with?("output") && mode != :output
          puts "WARNING: pin mode #{mode} not available on Milk-V Duo. Falling back to :output"
        end

        OUTPUT_MODES.include?(mode) ? _set_pin_mode(pin, PINMODE_OUTPUT) : _set_pin_mode(pin, PINMODE_INPUT)
      end
    end

    def set_pin_debounce(pin, debounce_time)
      puts "WARNING: Board#set_pin_debounce not available on Milk-V Duo. Ignoring..."
    end

    # digital_write implemented in C

    def digital_read(pin)
      self.update(pin, _digital_read(pin))
    end

    # pwm_write implemented in C

    def dac_write(pin, value)
      raise NotImplementedError, "Board#dac_write not available on Milk-V Duo"
    end

    def analog_read(pin, negative_pin=nil, gain=nil, sample_rate=nil)
      self.update(pin, _analog_read(pin))
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
