#
# Copied from main gem, except:
#   - Remove mutex from #atomically
#
module Denko
  module Behaviors
    module BusPeripheral
      include Component
      include Lifecycle

      alias  :bus :board

      before_initialize do
        params[:board] ||= params[:bus]
      end

      def atomically(&block)
        block.call
      end
    end
  end
end
