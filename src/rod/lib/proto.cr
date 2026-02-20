require "json"

module Rod
  module Lib
    module Proto
      struct RuntimeRemoteObjectID
        getter value : String

        def initialize(@value : String)
        end
      end

      struct RuntimeRemoteObjectType
        getter value : String

        def initialize(@value : String)
        end
      end

      struct RuntimeRemoteObjectSubtype
        getter value : String

        def initialize(@value : String)
        end
      end

      struct RuntimeRemoteObject
        property type : RuntimeRemoteObjectType?
        property subtype : RuntimeRemoteObjectSubtype?
        property value : ::JSON::Any?

        def initialize
          @type = nil
          @subtype = nil
          @value = nil
        end
      end

      struct RuntimeExceptionDetails
        property exception : RuntimeRemoteObject?
        property description : String?
        property value : ::JSON::Any?

        def initialize
          @exception = nil
          @description = nil
          @value = nil
        end
      end

      # Placeholder types for session and target IDs
      struct TargetSessionID
        getter value : String

        def initialize(@value : String = "")
        end
      end

      struct BrowserBrowserContextID
        getter value : String

        def initialize(@value : String = "")
        end
      end

      struct TargetTargetID
        getter value : String

        def initialize(@value : String = "")
        end
      end

      # TargetTargetInfoType enum (temporarily disabled due to compilation issues)
      # enum TargetTargetInfoType
      #   PageType = "page"
      #   BackgroundPageType = "background_page"
      #   ServiceWorkerType = "service_worker"
      #   SharedWorkerType = "shared_worker"
      #   BrowserType = "browser"
      #   OtherType = "other"
      # end
      alias TargetTargetInfoType = String

      # TargetCreateBrowserContext creates a new empty BrowserContext.
      struct TargetCreateBrowserContext
        include JSON::Serializable

        # (experimental) (optional) If specified, disposes this context when debugging session disconnects.
        @[JSON::Field(key: "disposeOnDetach")]
        getter dispose_on_detach : Bool?

        # (experimental) (optional) Proxy server, similar to the one passed to --proxy-server
        @[JSON::Field(key: "proxyServer")]
        getter proxy_server : String?

        # (experimental) (optional) Proxy bypass list, similar to the one passed to --proxy-bypass-list
        @[JSON::Field(key: "proxyBypassList")]
        getter proxy_bypass_list : String?

        # (experimental) (optional) An optional list of origins to grant unlimited cross-origin access to.
        # Parts of the URL other than those constituting origin are ignored.
        @[JSON::Field(key: "originsWithUniversalNetworkAccess")]
        getter origins_with_universal_network_access : Array(String)?

        def initialize(@dispose_on_detach : Bool? = nil, @proxy_server : String? = nil,
                       @proxy_bypass_list : String? = nil, @origins_with_universal_network_access : Array(String)? = nil)
        end

        # ProtoReq name
        def proto_req : String
          "Target.createBrowserContext"
        end

        # Call sends the request.
        def call(c : Client) : TargetCreateBrowserContextResult?
          # TODO: implement proper call
          # For now, return a dummy result
          TargetCreateBrowserContextResult.new(BrowserBrowserContextID.new("dummy"))
        end
      end

      # TargetCreateBrowserContextResult returned by TargetCreateBrowserContext.Call
      struct TargetCreateBrowserContextResult
        include JSON::Serializable

        # The id of the context created.
        @[JSON::Field(key: "browserContextId")]
        getter browser_context_id : BrowserBrowserContextID

        def initialize(@browser_context_id : BrowserBrowserContextID)
        end
      end

      # BrowserClose closes the browser.
      struct BrowserClose
        include JSON::Serializable

        def initialize
        end

        # ProtoReq name
        def proto_req : String
          "Browser.close"
        end
      end

      # TargetSetDiscoverTargets controls whether to discover available targets and notify via targetCreated/targetDestroyed events.
      struct TargetSetDiscoverTargets
        include JSON::Serializable

        # Whether to discover available targets.
        getter discover : Bool

        def initialize(@discover : Bool)
        end

        # ProtoReq name
        def proto_req : String
          "Target.setDiscoverTargets"
        end
      end

      # TargetDisposeBrowserContext deletes a browser context.
      struct TargetDisposeBrowserContext
        include JSON::Serializable

        @[JSON::Field(key: "browserContextId")]
        getter browser_context_id : BrowserBrowserContextID

        def initialize(@browser_context_id : BrowserBrowserContextID)
        end

        # ProtoReq name
        def proto_req : String
          "Target.disposeBrowserContext"
        end
      end

      # TargetCloseTarget closes the target.
      struct TargetCloseTarget
        include JSON::Serializable

        @[JSON::Field(key: "targetId")]
        getter target_id : TargetTargetID

        def initialize(@target_id : TargetTargetID)
        end

        # ProtoReq name
        def proto_req : String
          "Target.closeTarget"
        end
      end

      # TargetGetTargets returns all available targets.
      struct TargetGetTargets
        include JSON::Serializable

        def initialize
        end

        # ProtoReq name
        def proto_req : String
          "Target.getTargets"
        end
      end

      # TargetGetTargetsResult returned by TargetGetTargets.Call
      struct TargetGetTargetsResult
        include JSON::Serializable

        # The list of targets.
        getter target_infos : Array(TargetTargetInfo)

        def initialize(@target_infos : Array(TargetTargetInfo))
        end
      end

      # TargetTargetInfo information about a target.
      struct TargetTargetInfo
        include JSON::Serializable

        @[JSON::Field(key: "targetId")]
        getter target_id : TargetTargetID

        # List of types: https://source.chromium.org/chromium/chromium/src/+/main:content/browser/devtools/devtools_agent_host_impl.cc?ss=chromium&q=f:devtools%20-f:out%20%22::kTypeTab%5B%5D%22
        getter type : TargetTargetInfoType

        getter title : String
        getter url : String

        # Whether the target has an attached client.
        getter attached : Bool

        @[JSON::Field(key: "openerId")]
        # Opener target Id
        getter opener_id : TargetTargetID?

        @[JSON::Field(key: "canAccessOpener")]
        # Whether the target has access to the originating window.
        getter can_access_opener : Bool

        @[JSON::Field(key: "openerFrameId")]
        # Frame id of originating window (is only set if target has an opener).
        getter opener_frame_id : PageFrameID?

        @[JSON::Field(key: "browserContextId")]
        getter browser_context_id : BrowserBrowserContextID?

        # Provides additional details for specific target types. For example, for
        # the type of "page", this may be set to "portal" or "prerender".
        getter subtype : String?

        def initialize(@target_id : TargetTargetID, @type : TargetTargetInfoType, @title : String, @url : String,
                       @attached : Bool, @opener_id : TargetTargetID? = nil, @can_access_opener : Bool = false,
                       @opener_frame_id : PageFrameID? = nil, @browser_context_id : BrowserBrowserContextID? = nil,
                       @subtype : String? = nil)
        end
      end

      # TargetAttachToTarget attaches to the target with given id.
      struct TargetAttachToTarget
        include JSON::Serializable

        @[JSON::Field(key: "targetId")]
        getter target_id : TargetTargetID

        # (optional) Enables "flat" access to the session via specifying sessionId attribute in the commands.
        # We plan to make this the default, deprecate non-flattened mode,
        # and eventually retire it. See crbug.com/991325.
        getter flatten : Bool?

        def initialize(@target_id : TargetTargetID, @flatten : Bool? = nil)
        end

        # ProtoReq name
        def proto_req : String
          "Target.attachToTarget"
        end
      end

      # TargetAttachToTargetResult returned by TargetAttachToTarget.Call
      struct TargetAttachToTargetResult
        include JSON::Serializable

        # Id assigned to the session.
        @[JSON::Field(key: "sessionId")]
        getter session_id : TargetSessionID

        def initialize(@session_id : TargetSessionID)
        end
      end

      # PageFrameID unique frame identifier.
      struct PageFrameID
        getter value : String

        def initialize(@value : String = "")
        end
      end

      # PageEnable enables page domain notifications.
      struct PageEnable
        include JSON::Serializable

        def initialize
        end

        # ProtoReq name
        def proto_req : String
          "Page.enable"
        end
      end

      # Request interface (placeholder)
      abstract class Request
        abstract def proto_req : String
      end

      # Event interface (placeholder)
      abstract class Event
        abstract def proto_event : String
      end

      # Client interface to send the request.
      # So that this lib doesn't handle anything has side effect.
      abstract class Client
        abstract def call(ctx : Nil?, session_id : String, method : String, params) : Tuple(Bytes, Exception?)
      end

      # Sessionable type has a proto.TargetSessionID for its methods.
      module Sessionable
        abstract def get_session_id : TargetSessionID
      end

      # Contextable type has a context.Context for its methods.
      module Contextable
        abstract def get_context : Nil?
      end

      # call method with request and response containers.
      private def call(method : String, req, res, c : Client) : Exception?
        ctx = nil
        if c.is_a?(Contextable)
          ctx = c.get_context
        end

        session_id = ""
        if c.is_a?(Sessionable)
          session_id = c.get_session_id.value
        end

        bin, err = c.call(ctx, session_id, method, req)
        if err
          return err
        end
        if res.nil?
          return
        end

        # Parse JSON into res object
        # res should be a JSON::Serializable type
        begin
          res = typeof(res).from_json(bin)
          nil
        rescue ex
          ex
        end
      end
    end
  end
end
