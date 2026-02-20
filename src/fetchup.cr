module Fetchup
  class Instance
    property ctx : Nil? = nil
    property logger : Nil? = nil
    property http_client : Nil? = nil

    def initialize(dir : String, urls : Array(String))
      @dir = dir
      @urls = urls
    end

    def fetch : Nil
      raise "Fetchup not implemented yet"
    end
  end

  def self.new(dir : String, *urls : String) : Instance
    Instance.new(dir, urls.to_a)
  end

  def self.strip_first_dir(dir : String) : String
    # TODO: implement stripping first directory after extraction
    dir
  end
end
