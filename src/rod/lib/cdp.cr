module Rod
  module Lib
    module Cdp
      struct Event
        getter method : String
        getter params : ::JSON::Any?

        def initialize(@method : String, @params : ::JSON::Any? = nil)
        end
      end

      class Client
        def event : Channel(Event)
          Channel(Event).new
        end

        def call(ctx : Nil?, session_id : String, method : String, params) : Tuple(Bytes, Exception?)
          {Bytes.new(0), nil}
        end
      end
    end
  end
end
