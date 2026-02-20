module Leakless
  class Launcher
    def command(path : String, args : Array(String)) : Process
      Process.new(path, args)
    end
  end

  def self.new : Launcher
    Launcher.new
  end

  def self.support? : Bool
    false
  end

  def self.lock_port(port : Int32) : Nil
    # no-op
  end
end
