module Chitra
  struct Rect < Element
    include ShapeProperties

    # :nodoc:
    def initialize(@x : Float64, @y : Float64, @w : Float64, @h : Float64)
    end

    # :nodoc:
    def draw(cairo_ctx)
      cairo_ctx.rectangle @x, @y, @w, @h
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
    def rect(x, y, w, h)
      r = Rect.new(x, y, w, h)
      add_shape_properties(r)
    end
  end
end
