#
# Copied from main gem, except:
#   - Remove Behaviors::Poller
#   - Remove Behaviors::Listener
#   - Remove #divider
#   - Remove #_listen
#   - Added Behaviors::Reader
#
module Denko
  module AnalogIO
    class Input
      include Behaviors::InputPin
      include Behaviors::Reader
      include InputHelper
      include Behaviors::Lifecycle

      before_initialize do
        # Allow giving ADC unit with multiple pins as a board proxy.
        if params[:adc]
          params[:board] = params[:adc]
          params.delete(:adc)
        end
      end

      # Negative input on ADCs that support it.
      def negative_pin
        @negative_pin ||= params[:negative_pin]
      end

      # PGA gain for ADCs that support it
      def gain
        @gain ||= params[:gain]
      end

      # Sample rates for ADCs that support it.
      def sample_rate
        @sample_rate ||= params[:sample_rate]
      end

      attr_writer :divider, :negative_pin, :gain, :sample_rate

      # Allow ADCs to set this, so exact voltages can be calculated.
      attr_accessor :volts_per_bit

      def _read
        board.analog_read(pin, negative_pin, gain, sample_rate)
      end
    end
  end
end
