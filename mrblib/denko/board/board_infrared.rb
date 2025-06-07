module Denko
  class Board
    def infrared_emit(pin, frequency_khz, pulses)
      # IROutput class sets frequency in KHz, but need period and duty in ns.
      period = (1_000_000_000.0 / (frequency_khz * 1000)).round
      # Fixed 33.333 % duty cycle for now.
      duty = (0.33333 * period).round

      # Ensure pin muxed to hardware PWM, and set period.
      set_pin_mode(pin, :output_pwm, period: period)

      # Disable PWM (start with output low), then transmit.
      pwm_enable(pin, 0)
      tx_wave_ook(pin, duty, pulses)
    end
  end
end
