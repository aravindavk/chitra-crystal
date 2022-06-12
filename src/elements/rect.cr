module Chitra
  struct Rect < Element
    include ShapeProperties

    # :nodoc:
    def initialize(@x : Float64, @y : Float64, @w : Float64, @h : Float64)
    end

    # :nodoc:
    def draw(cairo_ctx)
      LibCairo.cairo_rectangle cairo_ctx, @x, @y, @w, @h
      draw_shape_properties(cairo_ctx)
    end

    # :nodoc:
    def to_s
      debug_text "rect(#{@x}, #{@y}, #{@w}, #{@h})"
    end
  end

  class Context
    # Draw rectangle shape
    # ```
    # ctx = Chitra.new
    # x y w h
    # ctx.rect 100, 100, 500, 500
    # ```
    def rect(x, y, w, h = 0.0)
      h = w if h == 0
      r = Rect.new(x, y, w.to_f64, h.to_f64)
      idx = add_shape_properties(r)

      draw_on_default_surface(@elements[idx])
    end
  end
end
