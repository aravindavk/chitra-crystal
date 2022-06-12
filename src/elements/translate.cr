module Chitra
  struct Translate < Element
    # :nodoc:
    def initialize(@x : Float64, @y : Float64)
    end

    # :nodoc:
    def draw(cairo_ctx)
      LibCairo.cairo_translate cairo_ctx, @x, @y
    end

    # :nodoc:
    def to_s
      "translate(#{@x}, #{@y})"
    end
  end

  class Context
    # Translate the canvas to given x and y
    # ```
    # ctx = Chitra.new
    # ctx.translate 100, 100
    # ctx.rect 0, 0, 500, 500
    # ```
    def translate(x, y)
      t = Translate.new(x, y)
      @elements << t

      @current_saved_context.add_transformation(t) if @current_saved_context.enabled

      draw_on_default_surface(t)
    end
  end
end
