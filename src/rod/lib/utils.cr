module Rod
  module Lib
    module Utils
      # Sleeper is a function that takes a context and returns an error or nil
      alias Sleeper = Proc(Nil?, Exception?)

      # MustToJSON encodes data to JSON string
      def self.must_to_json(data) : String
        data.to_json
      end

      # MustToJSONBytes encodes data to JSON bytes
      def self.must_to_json_bytes(data) : Bytes
        data.to_json.to_slice
      end
    end
  end
end
