module Denko
  class Board
    def pulse_read(pin, reset: false, reset_time: 0, pulse_limit: 100, timeout: 200)
      # GPIO, reset pulse time (us), reset pulse level (0 or 1), pulse limit, timeout(ms)
      data = read_pulses_us(pin, reset_time, reset, pulse_limit, timeout)
      self.update(pin, data)
    end

    # HC-SR04 uses 10 microseconds for trigger. Some others use 20us.
    def hcsr04_read(echo_pin, trigger_pin)
      microseconds = read_ultrasonic(trigger_pin, echo_pin, 10)
      self.update(echo_pin, microseconds)
    end
  end
end
