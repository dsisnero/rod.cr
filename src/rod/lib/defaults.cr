module Rod
  module Lib
    module Defaults
      # Trace is the default of rod.Browser.Trace .
      @@trace = false

      def self.trace : Bool
        @@trace
      end

      def self.trace=(value : Bool)
        @@trace = value
      end

      # Slow is the default of rod.Browser.SlowMotion .
      @@slow = Time::Span.zero

      def self.slow : Time::Span
        @@slow
      end

      def self.slow=(value : Time::Span)
        @@slow = value
      end

      # Monitor is the default of rod.Browser.ServeMonitor .
      @@monitor = ""

      def self.monitor : String
        @@monitor
      end

      def self.monitor=(value : String)
        @@monitor = value
      end

      # Show is the default of launcher.Launcher.Headless .
      @@show = false

      def self.show : Bool
        @@show
      end

      def self.show=(value : Bool)
        @@show = value
      end

      # Devtools is the default of launcher.Launcher.Devtools .
      @@devtools = false

      def self.devtools : Bool
        @@devtools
      end

      def self.devtools=(value : Bool)
        @@devtools = value
      end

      # Dir is the default of launcher.Launcher.UserDataDir .
      @@dir = ""

      def self.dir : String
        @@dir
      end

      def self.dir=(value : String)
        @@dir = value
      end

      # Port is the default of launcher.Launcher.RemoteDebuggingPort .
      @@port = "0"

      def self.port : String
        @@port
      end

      def self.port=(value : String)
        @@port = value
      end

      # Bin is the default of launcher.Launcher.Bin .
      @@bin = ""

      def self.bin : String
        @@bin
      end

      def self.bin=(value : String)
        @@bin = value
      end

      # Proxy is the default of launcher.Launcher.Proxy
      @@proxy = ""

      def self.proxy : String
        @@proxy
      end

      def self.proxy=(value : String)
        @@proxy = value
      end

      # LockPort is the default of launcher.Browser.LockPort
      @@lock_port = 2978

      def self.lock_port : Int32
        @@lock_port
      end

      def self.lock_port=(value : Int32)
        @@lock_port = value
      end

      # URL is the default websocket url for remote control a browser.
      @@url = ""

      def self.url : String
        @@url
      end

      def self.url=(value : String)
        @@url = value
      end

      # CDP is the default of cdp.Client.Logger
      @@cdp = nil # TODO: Logger type
      def self.cdp
        @@cdp
      end

      def self.cdp=(value)
        @@cdp = value
      end

      # Reset all flags to their init values.
      def self.reset : Nil
        @@trace = false
        @@slow = Time::Span.zero
        @@monitor = ""
        @@show = false
        @@devtools = false
        @@dir = ""
        @@port = "0"
        @@bin = ""
        @@proxy = ""
        @@lock_port = 2978
        @@url = ""
        @@cdp = nil
      end
    end
  end
end
