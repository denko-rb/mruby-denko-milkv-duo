module Denko
  class Board
    def tone(pin, frequency, duration=nil)
      period = (1_000_000_000.0 / frequency).round
      duty = (period * 0.33).round
      pwm_enable(pin, 0)
      pwm_set_period(pin, period)
      pwm_set_polarity(pin, 0)
      pwm_write(pin, duty)
      pwm_enable(pin, 1)
    end

    def no_tone(pin)
      pwm_write(pin, 0)
      pwm_enable(pin, 0)
    end
  end
end
