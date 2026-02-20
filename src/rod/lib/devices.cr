module Rod
  module Lib
    module Devices
      class ScreenSize
        getter width : Int32
        getter height : Int32

        def initialize(@width : Int32, @height : Int32)
        end
      end

      class Screen
        getter device_pixel_ratio : Float64
        getter horizontal : ScreenSize
        getter vertical : ScreenSize

        def initialize(@device_pixel_ratio : Float64, @horizontal : ScreenSize, @vertical : ScreenSize)
        end
      end

      class Device
        property capabilities : Array(String)
        property user_agent : String
        property accept_language : String
        property screen : Screen
        property title : String
        property clear : Bool
        property landscape : Bool

        def initialize
          @capabilities = [] of String
          @user_agent = ""
          @accept_language = ""
          @screen = Screen.new(1.0, ScreenSize.new(0, 0), ScreenSize.new(0, 0))
          @title = ""
          @clear = false
          @landscape = false
        end

        # Landscape clones the device and set it to landscape mode.
        def landscape : Device
          d = clone
          d.landscape = true
          d
        end

        # IsClear type.
        def is_clear : Bool
          @clear
        end
      end

      # Clear is used to clear overrides.
      Clear = Device.new.tap(&.clear=(true))

      # Predefined device
      LAPTOP_WITH_MDPI_SCREEN = Device.new.tap do |d|
        d.title = "Laptop with MDPI screen"
        d.capabilities = [] of String
        d.user_agent = ""
        d.accept_language = ""
        d.screen = Screen.new(
          1.0,
          ScreenSize.new(0, 0),
          ScreenSize.new(0, 0)
        )
      end

      private def has(arr : Array(String), str : String) : Bool
        arr.includes?(str)
      end
    end
  end
end
