module Chitra
  struct Image < Element
    # :nodoc:
    def initialize(@path : String, @x : Float64, @y : Float64)
    end

    # :nodoc:
    def draw(cairo_ctx)
      surface = Cairo::Surface.new(@path)
      cairo_ctx.set_source_surface(surface, @x, @y)
      cairo_ctx.paint
    end

    # :nodoc:
    def to_s
      debug_text("image(#{@path}, #{@x}, #{@y})")
    end
  end

  class Context
    # Draw image
    # ```
    # ctx = Chitra.new
    # ctx.image "logo.png", 100, 100
    # ```
    def image(path, x, y)
      i = Image.new(path, x, y)
      idx = add_shape_properties(i)

      draw_on_default_surface(@elements[idx])
    end
  end
end
