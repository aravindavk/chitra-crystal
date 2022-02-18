module Chitra
  struct Oval < Element
    # :nodoc:
    def initialize(@x : Float64, @y : Float64, @w : Float64, @h : Float64)
    end

    # :nodoc:
    def draw(cairo_ctx)
      cairo_ctx.save
      cairo_ctx.translate(@x + @w/2, @y + @h/2)
      cairo_ctx.scale(@w/2, @h/2)
      cairo_ctx.arc(0.0, 0.0, 1.0, 0.0, 2.0 * Math::PI)
      cairo_ctx.restore
      draw_shape_properties(cairo_ctx)
    end

    # :nodoc:
    def to_s
      debug_text("oval(#{@x}, #{@y}, #{@w}, #{@h})")
    end
  end

  class Context
    # Draw oval shape
    # ```
    # ctx = Chitra.new
    # x y w h
    # ctx.oval 100, 100, 500, 500
    # ```
    def oval(x, y, w = 2.0, h = 0.0)
      h = w if h == 0.0
      o = Oval.new(x, y, w.to_f64, h.to_f64)
      idx = add_shape_properties(o)

      draw_on_default_surface(@elements[idx])
    end
  end
end
