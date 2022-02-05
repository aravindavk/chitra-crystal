module Chitra
  struct Background < Element
    include ShapeProperties

    # :nodoc:
    def initialize(@w : Float64, @h : Float64)
    end

    # :nodoc:
    def draw(cairo_ctx)
      cairo_ctx.rectangle 0, 0, @w, @h
      draw_shape_properties(cairo_ctx)
    end

    # :nodoc:
    def to_s
      debug_text "background()"
    end
  end

  class Context
    # Fill background color
    # ```
    # ctx = Chitra.new
    # # white background
    # ctx.background 1, 0, 0
    # ```
    def background(r, g, b, a = 1.0)
      color_validate(r, g, b, a)
      bg = Background.new(@size.width, @size.height)
      idx = add_shape_properties(bg)

      # Override the new values for the background
      ele = @elements[idx]
      ele.stroke_width = 0
      ele.fill.r = r.to_f64
      ele.fill.g = g.to_f64
      ele.fill.b = b.to_f64
      ele.fill.a = a.to_f64
      @elements[idx] = ele

      draw_on_default_surface(@elements[idx])
    end

    # Fill background color(Gray scale)
    # ```
    # ctx = Chitra.new
    # # white background
    # ctx.background 1
    # ```
    def background(gray, a = 1.0)
      r = g = b = gray
      background(r, g, b, a)
    end
  end
end
