module Chitra
  struct Image < Element
    # :nodoc:
    def initialize(@path : String, @x : Float64, @y : Float64)
    end

    # :nodoc:
    def draw(cairo_ctx)
      surface = Chitra.image_surface(@path)
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

    # Get width of the image
    # ```
    # ctx = Chitra.new
    # w = ctx.image_width "logo.png"
    # ```
    def image_width(path)
      surface = Chitra.image_surface(path)
      LibCairo.cairo_image_surface_get_width(surface)
    end

    # Get height of the image
    # ```
    # ctx = Chitra.new
    # h = ctx.image_height "logo.png"
    # ```
    def image_height(path)
      surface = Chitra.image_surface(path)
      LibCairo.cairo_image_surface_get_height(surface)
    end

    # Get width and height of the image
    # ```
    # ctx = Chitra.new
    # w, h = ctx.image_size "logo.png"
    # ```
    def image_size(path)
      {image_width(path), image_height(path)}
    end
  end
end
