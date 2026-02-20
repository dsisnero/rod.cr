module Rod
  alias Proto = Lib::Proto

  # TryError error.
  class TryError < Exception
    getter value : ::JSON::Any?
    getter stack : String

    def initialize(@value, @stack : String)
      super("error value: #{@value.inspect}\n#{@stack}")
    end

    # Unwrap returns the underlying error if value is an error
    def unwrap : Exception?
      if @value.is_a?(Exception)
        @value.as(Exception)
      elsif !@value.nil?
        Exception.new(@value.to_s)
      end
    end
  end

  # ExpectElementError error.
  class ExpectElementError < Exception
    getter remote_object : Proto::RuntimeRemoteObject

    def initialize(@remote_object : Proto::RuntimeRemoteObject)
      super("expect js to return an element, but got: #{Utils.must_to_json(self)}")
    end
  end

  # ExpectElementsError error.
  class ExpectElementsError < Exception
    getter remote_object : Proto::RuntimeRemoteObject

    def initialize(@remote_object : Proto::RuntimeRemoteObject)
      super("expect js to return an array of elements, but got: #{Utils.must_to_json(self)}")
    end
  end

  # ElementNotFoundError error.
  class ElementNotFoundError < Exception
    def initialize
      super("cannot find element")
    end
  end

  # NotFoundSleeper returns ElementNotFoundError on the first call.
  def self.not_found_sleeper : Utils::Sleeper
    ->(_ctx : Nil?) { ElementNotFoundError.new }
  end

  # ObjectNotFoundError error.
  class ObjectNotFoundError < Exception
    getter remote_object : Proto::RuntimeRemoteObject

    def initialize(@remote_object : Proto::RuntimeRemoteObject)
      super("cannot find object: #{Utils.must_to_json(self)}")
    end
  end

  # EvalError error.
  class EvalError < Exception
    getter exception_details : Proto::RuntimeExceptionDetails

    def initialize(@exception_details : Proto::RuntimeExceptionDetails)
      desc = @exception_details.description || ""
      val = @exception_details.value
      super("eval js error: #{desc} #{val}")
    end
  end

  # NavigationError error.
  class NavigationError < Exception
    getter reason : String

    def initialize(@reason : String)
      super("navigation failed: #{@reason}")
    end
  end

  # PageCloseCanceledError error.
  class PageCloseCanceledError < Exception
    def initialize
      super("page close canceled")
    end
  end

  # NotInteractableError error. Check the doc of Element.Interactable for details.
  class NotInteractableError < Exception
    def initialize
      super("element is not cursor interactable")
    end
  end

  # InvisibleShapeError error.
  class InvisibleShapeError < Exception
    getter element : Element

    def initialize(@element : Element)
      super("element has no visible shape or outside the viewport: #{@element}")
    end

    # Unwrap returns NotInteractableError
    def unwrap : Exception
      NotInteractableError.new
    end
  end

  # CoveredError error.
  class CoveredError < Exception
    getter element : Element

    def initialize(@element : Element)
      super("element covered by: #{@element}")
    end

    # Unwrap returns NotInteractableError
    def unwrap : Exception
      NotInteractableError.new
    end
  end

  # NoPointerEventsError error.
  class NoPointerEventsError < Exception
    getter element : Element

    def initialize(@element : Element)
      super("element's pointer-events is none: #{@element}")
    end

    # Unwrap returns NotInteractableError
    def unwrap : Exception
      NotInteractableError.new
    end
  end

  # PageNotFoundError error.
  class PageNotFoundError < Exception
    def initialize
      super("cannot find page")
    end
  end

  # NoShadowRootError error.
  class NoShadowRootError < Exception
    getter element : Element

    def initialize(@element : Element)
      super("element has no shadow root: #{@element}")
    end
  end
end
