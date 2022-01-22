require "./helpers"
require "./surfaces/*"

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
    def initialize(w : Int32, h : Int32)
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

    private def get_surface(out_ext)
      # Macro to add switch cases for each available surfaces
      {% begin %}
        case "Chitra::#{out_ext.titleize}Surface"
            {% for name in Surface.subclasses %}
            when {{ name.stringify }}
              {{ name }}.new(@output_file, @size.width, @size.height)
            {% end %}
        else
          nil
        end
      {% end %}
    end

    private def available_surfaces
      surfaces = [] of String
      {% begin %}
        {% for name in Surface.subclasses %}
          surfaces << {{ name.stringify.underscore.split("_")[0].downcase.gsub(/chitra::/, "") }}
        {% end %}
      {% end %}

      surfaces
    end

    # Save the output to a file.
    # ```
    # ctx = Chitra::Context.new
    # #        filename
    # ctx.save "hello.png"
    # ```
    def save(file)
      @output_file = file
      return if @output_file == ""

      _base, _sep, out_ext = @output_file.rpartition(".")

      surface = get_surface(out_ext)
      if surface.nil?
        raise Exception.new("Unknown output file format. Supported formats: #{available_surfaces.join(",")}")
      end

      cairo_ctx = Cairo::Context.new surface.surface
      if @debug
        @elements.each do |ele|
          puts ele.to_s
        end
      end

      @elements.each do |ele|
        ele.render(cairo_ctx)
      end

      surface.draw
    end
  end
end
