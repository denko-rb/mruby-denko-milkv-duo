#
# Copied from main gem and disabled:
#   - No threading on mruby, so no background polling, raise NotImplemented Error.
#   - Change super if defined?(super) to
#   -   begin; super; rescue NoMethodError; end
#
module Denko
  module Behaviors
    module Poller
      include Reader
      # include Threaded

      def poll_using(method, interval, *args, &block)
        raise NotImplementedError, "Background thread polling not available in mruby"
      end

      def poll(interval, *args, &block)
        poll_using(self.method(:_read), interval, *args, &block)
      end

      def stop
        begin; super; rescue NoMethodError; end
        remove_callbacks :poll
      end
    end
  end
end
