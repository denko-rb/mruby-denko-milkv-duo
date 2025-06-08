module Denko
  class Board
    # HC-SR04 uses 10 microseconds for trigger. Some others use 20us.
    def hcsr04_read(echo_pin, trigger_pin)
      microseconds = read_ultrasonic(trigger_pin, echo_pin, 10)
      self.update(echo_pin, microseconds)
    end
  end
end
