module Goob
  class Observable(T)
    @subscribers = [] of Channel(T)

    def subscribe(ctx : Nil? = nil) : Channel(T)
      ch = Channel(T).new
      @subscribers << ch
      ch
    end

    def publish(msg : T) : Nil
      @subscribers.each do |channel|
        channel.send(msg)
      rescue Channel::ClosedError
        # ignore closed channel
      end
    end

    def close
      @subscribers.each(&.close)
      @subscribers.clear
    end
  end

  def self.new(ctx : Nil? = nil) : Observable(Message)
    Observable(Message).new
  end

  # Placeholder for Message type (should be defined elsewhere)
  class Message
  end
end
