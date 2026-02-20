module Rod
  class Element
    getter id : String?

    def initialize(@id : String? = nil)
    end

    def to_s(io : IO) : Nil
      io << "Element"
      io << "(#{@id})" if @id
    end
  end
end
