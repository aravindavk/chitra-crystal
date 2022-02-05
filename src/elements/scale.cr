module Chitra
  struct Scale < Element
    # :nodoc:
    def initialize(@scale_x : Float64, @scale_y : Float64 = 0.0)
    end

    # :nodoc:
    def draw(cairo_ctx)
      scale_y = @scale_y == 0 ? @scale_x : @scale_y
      cairo_ctx.scale @scale_x, scale_y
    end

    # :nodoc:
    def to_s
      "scale(#{@scale_x}, #{@scale_y})"
    end
  end

  class Context
    # Scale the canvas with the given x and y scale factors.
    # direction.
    # ```
    # ctx = Chitra.new 200
    # ctx.scale 2
    # ctx.rect 40, 40, 40, 40
    # ```
    # Different scaling for x and y
    # ```
    # ctx = Chitra.new 200
    # ctx.scale 2, 1
    # ctx.rect 40, 40, 40, 40
    # ```
    # Change the center of Scale
    def scale(scale_x, scale_y = 0)
      s = Scale.new(scale_x, scale_y)
      @elements << s

      draw_on_default_surface(s)
    end
  end
end
