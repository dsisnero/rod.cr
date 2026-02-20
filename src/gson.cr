module Gson
  # JSON represents a JSON value, wrapping Crystal's JSON::Any for compatibility
  class JSON
    def initialize(@raw : ::JSON::Any)
    end

    # Returns the underlying JSON::Any
    def raw
      @raw
    end

    # Get a field by key, returns a new JSON wrapper
    def get(key : String) : JSON
      JSON.new(@raw[key])
    end

    # Get integer value, assumes the underlying value is Int
    def int : Int64
      @raw.as_i64
    end

    # Get string value, assumes the underlying value is String
    def str : String
      @raw.as_s
    end

    # Convert to pretty JSON string with given prefix and indent
    def json(prefix : String = "", indent : String = "  ") : String
      @raw.to_json
    end

    # For convenience, delegate as_i, as_f, as_b, etc.
    delegate as_i, as_f, as_b, as_a, as_h, to: @raw
  end

  # Create a JSON wrapper from any serializable value
  def self.new(value) : JSON
    JSON.new(::JSON.parse(value.to_json))
  end

  # Create a JSON wrapper from raw bytes (assumes UTF-8 JSON)
  def self.new_from(bytes : Bytes) : JSON
    JSON.new(::JSON.parse(String.new(bytes)))
  end

  # Create a JSON wrapper representing an integer
  def self.int(value : Int) : JSON
    JSON.new(::JSON::Any.new(value.to_i64))
  end

  # Create a JSON wrapper representing a float
  def self.num(value : Float) : JSON
    JSON.new(::JSON::Any.new(value))
  end

  # Alias for num for compatibility
  def self.num(value : Int) : JSON
    JSON.new(::JSON::Any.new(value.to_f64))
  end
end
