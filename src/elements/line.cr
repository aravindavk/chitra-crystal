module Chitra
  struct Line < Element
    include ShapeProperties

    # :nodoc:
    def initialize(@x1 : Float64, @y1 : Float64, @x2 : Float64, @y2 : Float64)
    end

    # :nodoc:
    def draw(cairo_ctx)
      cairo_ctx.line @x1, @y1, @x2, @y2
      draw_shape_properties(cairo_ctx)
    end

    # :nodoc:
    def to_s
      debug_text "line(#{@x1}, #{@y1}, #{@x2}, #{@y2})"
    end
  end

  class Context
    # Draw a line
    # ```
    # ctx = Chitra.new
    # x y w h
    # ctx.line 100, 100, 500, 500
    # ```
    def line(x1, y1, x2, y2)
      l = Line.new(x1, y1, x2, y2)
      idx = add_shape_properties(l)

      draw_on_default_surface(@elements[idx])
    end
  end
end
