require "./helpers"

module Chitra
  class Context
    include ShapeProperties
    property size = Size.new

    # Get width of the canvas
    # ```
    # #                         width height
    # ctx = Chitra::Context.new 1600, 900
    # puts ctx.width # 1600
    # ```
    def width
      @size.width
    end

    # Get height of the canvas
    # ```
    # #                         width height
    # ctx = Chitra::Context.new 1600, 900
    # puts ctx.height # 900
    # ```
    def height
      @size.height
    end

    # Initialize the Chitra drawing Context with default surface size
    # ```
    # ctx = Chitra::Context.new
    # ```
    def initialize
      @output_file = ""
      @out_ext = ""
      @output_type = ""
      @elements = [] of Element
      @debug = false
    end

    # Initialize the Chitra drawing Context
    # ```
    # #                         width height
    # ctx = Chitra::Context.new 1600, 900
    # ```
    def initialize(w : Float64, h : Float64)
      @size.width = w
      @size.height = h
      initialize
    end

    # Enable debug messages to verify if any
    # property applied to an element is not maching
    # ```
    # ctx = Chitra::Context.new
    # ctx.enable_debug
    # ```
    def enable_debug
      @debug = true
    end
  end
end
