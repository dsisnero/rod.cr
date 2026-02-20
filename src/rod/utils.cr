module Rod
  # Logger interface.
  abstract class Logger
    abstract def println(*args)
  end

  # Simple logger that prints to STDOUT.
  class StdLogger < Logger
    def initialize(@output : IO = STDOUT)
    end

    def println(*args)
      @output.puts args.join(" ")
    end
  end

  # DefaultLogger for rod.
  DEFAULT_LOGGER = StdLogger.new.tap do |_|
    # progname not used
  end

  # CDPClient is usually used to make rod side-effect free. Such as proxy all IO of rod.
  abstract class CDPClient
    abstract def event : Channel(Lib::Cdp::Event)
    abstract def call(ctx : Nil?, session_id : String, method : String, params) : Tuple(Bytes, Exception?)
  end

  # Message represents a cdp.Event.
  class Message
    getter session_id : Lib::Proto::TargetSessionID
    getter method : String
    property lock : Mutex
    property data : ::JSON::Any?
    property event : ::JSON::Any?

    def initialize(@session_id : Lib::Proto::TargetSessionID, @method : String)
      @lock = Mutex.new
      @data = nil
      @event = nil
    end

    # Load data into e, returns true if e matches the event type.
    def load(e : Lib::Proto::Event) : Bool
      false # TODO
    end
  end

  # DefaultLogger for rod. (defined above)

  # DefaultSleeper generates the default sleeper for retry
  DEFAULT_SLEEPER = -> { ->(_ctx : Nil?) { nil } } # TODO: implement backoff sleeper

  # eFunc type from must.go
  alias EFunc = Proc(Array(::JSON::Any), Nil)

  # Try try fn with recover, return the panic as rod.ErrTry.
  def self.try(& : -> _) : Exception?
    begin
      yield
      nil
    rescue ex
      ex
    end
  end
end
