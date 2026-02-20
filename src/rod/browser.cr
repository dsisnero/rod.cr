module Rod
  # Browser implements these interfaces.
  # var (
  #   _ proto.Client      = &Browser{}
  #   _ proto.Contextable = &Browser{}
  # )

  # Browser represents the browser.
  # It doesn't depends on file system, it should work with remote browser seamlessly.
  # To check the env var you can use to quickly enable options from CLI, check here:
  # https://pkg.go.dev/github.com/go-rod/rod/lib/defaults
  class Browser
    # BrowserContextID is the id for incognito window
    property browser_context_id : Lib::Proto::BrowserBrowserContextID

    property e : EFunc
    property ctx : Nil?
    property sleeper : -> Lib::Utils::Sleeper
    property logger : Logger
    property slow_motion : Time::Span
    property trace : Bool
    property monitor : String
    property default_device : Lib::Devices::Device
    property control_url : String
    property client : CDPClient
    property event : Goob::Observable(Goob::Message)
    property targets_lock : Mutex
    property states : Hash(String, ::JSON::Any)

    # New creates a controller.
    # DefaultDevice to emulate is set to [devices.LaptopWithMDPIScreen].Landscape(), it will change the default
    # user-agent and can make the actual view area smaller than the browser window on headful mode,
    # you can use [Browser.NoDefaultDevice] to disable it.
    def initialize
      @browser_context_id = Lib::Proto::BrowserBrowserContextID.new
      @e = ->(_args : Array(::JSON::Any)) { nil }
      @ctx = nil
      @sleeper = DEFAULT_SLEEPER
      @logger = DEFAULT_LOGGER
      @slow_motion = Lib::Defaults.slow
      @trace = Lib::Defaults.trace
      @monitor = Lib::Defaults.monitor
      @default_device = Lib::Devices::LAPTOP_WITH_MDPI_SCREEN.landscape
      @control_url = Lib::Defaults.url
      @client = Lib::Cdp::Client.new
      @event = Goob.new
      @targets_lock = Mutex.new
      @states = Hash(String, ::JSON::Any).new
    end

    # Incognito creates a new incognito browser.
    def incognito : Browser?
      res = Lib::Proto::TargetCreateBrowserContext.new.call(self)
      return unless res

      incognito = clone
      incognito.browser_context_id = res.browser_context_id
      incognito
    end

    # ControlURL set the url to remote control browser.
    def control_url(url : String) : Browser
      @control_url = url
      self
    end

    # SlowMotion set the delay for each control action, such as the simulation of the human inputs.
    def slow_motion(delay : Time::Span) : Browser
      @slow_motion = delay
      self
    end

    # Trace enables/disables the visual tracing of the input actions on the page.
    def trace(enable : Bool) : Browser
      @trace = enable
      self
    end

    # Monitor address to listen if not empty. Shortcut for [Browser.ServeMonitor].
    def monitor(url : String) : Browser
      @monitor = url
      self
    end

    # Logger overrides the default log functions for tracing.
    def logger(l : Logger) : Browser
      @logger = l
      self
    end

    # Client set the cdp client.
    def client(c : CDPClient) : Browser
      @client = c
      self
    end

    # DefaultDevice sets the default device for new page to emulate in the future.
    # Default is [devices.LaptopWithMDPIScreen].
    # Set it to [devices.Clear] to disable it.
    def default_device(d : Lib::Devices::Device) : Browser
      @default_device = d
      self
    end

    # NoDefaultDevice is the same as [Browser.DefaultDevice](devices.Clear).
    def no_default_device : Browser
      default_device(Lib::Devices::Clear)
    end

    # Connect to the browser and start to control it.
    # If fails to connect, try to launch a local browser, if local browser not found try to download one.
    def connect : Exception?
      nil # TODO
    end

    # Close the browser.
    def close : Exception?
      nil # TODO
    end

    # Page creates a new browser tab. If opts.URL is empty, the default target will be "about:blank".
    def page(opts : Lib::Proto::TargetCreateTarget) : Page?
      nil # TODO
    end

    # Pages retrieves all visible pages.
    def pages : Array(Page)?
      nil # TODO
    end

    # PageFromSession is used for low-level debugging.
    def page_from_session(session_id : Lib::Proto::TargetSessionID) : Page
      Page.new # TODO
    end

    # PageFromTarget gets or creates a Page instance.
    def page_from_target(target_id : Lib::Proto::TargetTargetID) : Page?
      nil # TODO
    end

    # EachEvent is similar to [Page.EachEvent], but catches events of the entire browser.
    def each_event(callbacks : Array) : Proc(Nil)
      -> { nil } # TODO
    end

    # WaitEvent waits for the next event for one time. It will also load the data into the event object.
    def wait_event(e : Lib::Proto::Event) : Proc(Nil)
      -> { nil } # TODO
    end

    # Event of the browser.
    def event : Channel(Message)
      Channel(Message).new # TODO
    end

    # IgnoreCertErrors switch. If enabled, all certificate errors will be ignored.
    def ignore_cert_errors(enable : Bool) : Exception?
      nil # TODO
    end

    # GetCookies from the browser.
    def get_cookies : Array(Lib::Proto::NetworkCookie)?
      nil # TODO
    end

    # SetCookies to the browser. If the cookies is nil it will clear all the cookies.
    def set_cookies(cookies : Array(Lib::Proto::NetworkCookieParam)?) : Exception?
      nil # TODO
    end

    # WaitDownload returns a helper to get the next download file.
    def wait_download(dir : String) : Proc(Lib::Proto::PageDownloadWillBegin?)
      -> { nil } # TODO
    end

    # Version info of the browser.
    def version : Lib::Proto::BrowserGetVersionResult?
      nil # TODO
    end

    # Call implements the proto.Client to call raw cdp interface directly.
    def call(ctx : Nil?, session_id : String, method : String, params) : Tuple(Bytes, Exception?)
      @client.call(ctx, session_id, method, params)
    end

    # set stores the previous cdp call of same type.
    private def set(session_id : Lib::Proto::TargetSessionID, method_name : String, params)
      # TODO
    end
  end
end
