#
# Copied from main gem, except:
#   - Change super if defined?(super) to
#   -   begin; super; rescue NoMethodError; end
#
module Denko
  module Behaviors
    module Listener
      include Callbacks

      attr_reader :divider

      #
      # These delegate to #_listen and #_stop_listener,
      # which should be defined in the including class.
      #
      def listen(divider=nil, &block)
        @divider = divider || @listener
        stop
        add_callback(:listen, &block) if block_given?
        _listen(@divider)
      end

      def stop
        begin; super; rescue NoMethodError; end
        _stop_listener
        remove_callbacks :listen
      end
    end
  end
end
