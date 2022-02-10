module Chitra
  struct Point < Element
    include ShapeProperties

    # :nodoc:
    def initialize(@x : Float64, @y : Float64)
    end

    # :nodoc:
    def draw(cairo_ctx)
      cairo_ctx.save
      cairo_ctx.translate(@x + @stroke_width/2, @y + @stroke_width/2)
      cairo_ctx.scale(@stroke_width/2, @stroke_width/2)
      cairo_ctx.arc(0.0, 0.0, 1.0, 0.0, 2.0 * Math::PI)
      cairo_ctx.restore
      draw_shape_properties(cairo_ctx)
    end

    # :nodoc:
    def to_s
      debug_text "point(#{@x}, #{@y})"
    end
  end

  class Context
    # Draw a Point
    # ```
    # ctx = Chitra.new
    # x y
    # ctx.point 100, 100
    # ```
    def point(x, y)
      p = Point.new(x, y)
      idx = add_shape_properties(p)

      draw_on_default_surface(@elements[idx])
    end
  end
end
