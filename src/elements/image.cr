module Chitra
  struct Image < Element
    # :nodoc:
    def initialize(@path : String, @x : Float64, @y : Float64)
    end

    # :nodoc:
    def draw(cairo_ctx)
      surface = LibCairo.cairo_image_surface_create_from_png(@path.to_unsafe)
      LibCairo.cairo_set_source_surface(cairo_ctx, surface, @x, @y)
      LibCairo.cairo_paint(cairo_ctx)
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
