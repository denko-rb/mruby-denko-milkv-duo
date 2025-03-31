#
# Copied from main gem, except:
#   - Removed #blink and #blink_interval=
#   - Moved shortcut constructor in here from ../led.rb
#
module Denko
  module LED
    class Base < PulseIO::PWMOutput
    end

    def self.new(options={})
      self::Base.new(options)
    end
  end
end
