#
# Copied from main gem, except:
#   - Remove mutex
#   - Remove protected
#
module Denko
  module Behaviors
    module State
      include Lifecycle

      # Force state initialization.
      after_initialize do
        state
      end

      attr_accessor :state

      def update_state(value)
        self.state = value if value
      end
    end
  end
end
