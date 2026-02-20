module Rod
  module Lib
    module Launcher
      class Launcher
        property headless : Bool = false
        property devtools : Bool = false
        property user_data_dir : String = ""
        property remote_debugging_port : String = "0"
        property bin : String = ""
        property proxy : String = ""
      end

      class Browser
        property lock_port : Int32 = 0
      end
    end
  end
end
