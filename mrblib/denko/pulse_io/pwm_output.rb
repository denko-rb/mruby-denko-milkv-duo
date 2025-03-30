#
# Copied from main gem, except:
#   - Removed call to interrupt_with
#   - Improved handling of Linux boards vs. Arduino MCUs (needs to be ported to CRuby gem)
#
module Denko
  module PulseIO
    class PWMOutput < DigitalIO::Output
      include Behaviors::Lifecycle

      before_initialize do
        params[:mode] = :output_pwm
      end

      def duty=(percent)
        if board.platform == :arduino
          pwm_write((percent / 100.0 * pwm_high).round)
        else
          pwm_write((percent / 100.0 * period).round)
        end
      end

      def digital_write(value)
        if board.platform == :arduino
          pwm_disable if pwm_enabled
          super(value)
        else
          if value == 1
            pwm_write(period)
          else
            pwm_write(0)
          end
        end
      end

      # Raw write. Takes nanoseconds on Linux, 0..pwm_high on Arduino.
      def pwm_write(value)
        pwm_enable unless pwm_enabled
        board.pwm_write(pin, value)
        self.state = value
      end
      alias :write :pwm_write

      def frequency
        @frequency ||= params[:frequency] || 1000
      end

      def period
        @period ||= (1_000_000_000.0 / frequency).round
      end

      def resolution
        @resolution ||= params[:resolution] || board.analog_write_resolution
      end

      def pwm_high
        @pwm_high ||= (2**resolution-1)
      end

      def _frequency=(value)
        @frequency = value
        @period    = nil
      end

      def _resolution=(value)
        @resolution = value
        @pwm_high   = nil
      end

      def frequency=(value)
        self._frequency = value
        pwm_enable
      end

      def resolution=(value)
        self._resolution = value
        pwm_enable
      end

      def pwm_settings_hash
        { frequency: frequency, period: period, resolution: resolution }
      end

      def pwm_enable(freq: nil, res: nil)
        self._frequency  = freq if freq
        self._resolution = res if res

        board.set_pin_mode(pin, :output_pwm, pwm_settings_hash)
        @mode = :output_pwm
      end

      def pwm_disable
        self.mode = :output if board.platform == :arduino
      end

      def pwm_enabled
        mode == :output_pwm
      end
    end
  end
end
