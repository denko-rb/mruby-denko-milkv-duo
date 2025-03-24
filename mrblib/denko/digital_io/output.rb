#
# Copied from main gem, except:
#   - Remove Behaviors::Threaded
#   - Remove call to .interrupt_with
#   - Remove #digital_read in call to .after_initialize
#   - Remove Behaviors::Callback
#   - Remove #pre_callback_filter
#
module Denko
  module DigitalIO
    class Output
      include Behaviors::OutputPin
      include Behaviors::Lifecycle

      def digital_write(value)
        @board.digital_write(@pin, value)
        self.state = value
      end

      alias :write :digital_write

      def low
        digital_write(board.low)
      end

      def high
        digital_write(board.high)
      end

      def toggle
        state == board.low ? high : low
      end

      alias :off :low
      alias :on  :high

      def high?; state == board.high end
      def low?;  state == board.low  end

      alias :on?  :high?
      alias :off? :low?
    end
  end
end
